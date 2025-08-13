/*
Track warehouse inventory locations and know what is where.
*/
package warehouse

import (
	"sync"
)

type WarehouseCache struct {
	inventory map[string]any
	mu sync.RWMutex
}

func NewWarehouseCache() *WarehouseCache { 
	return &WarehouseCache{
		inventory: make(map[string]any),
	}
}

// Populate the cache with data from postgres.
func (wc *WarehouseCache) Setup() {
	return 
}
