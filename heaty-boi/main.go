package main

import (
	"bytes"
	"encoding/csv"
	"fmt"
	"log"
	"os/exec"
	"strconv"
)

const (
	criticalTemp = 80
	startTemp    = 50
)

func main() {
	for {
		if records, err := getGPUTemp(); err != nil {
			log.Fatal(err)
		} else {
			if err := parseRecords(records); err != nil {
				log.Fatal(err)
			}
		}
	}
}

func parseRecords(records [][]string) error {
	for _, row := range records {
		index := row[0]
		temp := row[1]
		fmt.Printf("GPU %s has a temp of %sC\n", index, temp)
		tempInt, err := strconv.ParseInt(temp, 10, 64)
		if err != nil {
			return err
		}
		if tempInt >= 80 {
			fmt.Println("gpu temp above 80, stopping miner")
			if err := stopMiner(); err != nil {
				return err
			}
			fmt.Println("miner stopped, letting chips chill for a bit")
			if err := processCriticalTemperatureEvent(); err != nil {
				return err
			}
			fmt.Println("chips are chilly, resuming miner")
			if err := startMiner(); err != nil {
				return err
			}
			fmt.Println("miner resumed")
			break
		}
	}
	return nil
}

func processCriticalTemperatureEvent() error {
	for {
		records, err := getGPUTemp()
		if err != nil {
			return err
		}
		temps := []int64{}
		for _, row := range records {
			temp := row[1]
			tempInt, err := strconv.ParseInt(temp, 10, 64)
			if err != nil {
				return err
			}
			temps = append(temps, tempInt)
			if len(temps) == len(records) {
				avgTemp := avg(temps)
				if avgTemp <= startTemp {
					return nil
				}
			}
			fmt.Println("chips too warm still...")
		}
	}
}

func getGPUTemp() ([][]string, error) {
	out, err := exec.Command(
		"nvidia-smi",
		"--query-gpu=index,temperature.gpu",
		"--format=csv,noheader,nounits",
	).Output()
	if err != nil {
		return nil, err
	}
	csvReader := csv.NewReader(bytes.NewReader(out))
	csvReader.TrimLeadingSpace = true
	return csvReader.ReadAll()
}

func stopMiner() error {
	_, err := exec.Command(
		"systemctl",
		"stop",
		"miner",
	).Output()
	return err
}

func startMiner() error {
	_, err := exec.Command(
		"systemctl",
		"start",
		"miner",
	).Output()
	return err
}
