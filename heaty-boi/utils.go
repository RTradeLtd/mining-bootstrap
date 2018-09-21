package main

func avg(numbers []int64) int64 {
	return sum(numbers) / int64(len(numbers))
}

func sum(numbers []int64) int64 {
	total := int64(0)
	for _, v := range numbers {
		total = total + v
	}
	return total
}

func min(numbers []int64) int64 {
	lowest := int64(0)
	for k, v := range numbers {
		if k == 0 {
			lowest = v
			continue
		}
		if v < lowest {
			lowest = v
		}
	}
	return lowest
}

func max(numbers []int64) int64 {
	highest := int64(0)
	for k, v := range numbers {
		if k == 0 {
			highest = v
			continue
		}
		if v > highest {
			highest = v
		}
	}
	return highest
}
