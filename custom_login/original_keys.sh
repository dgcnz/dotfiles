#!/bin/bash

hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x700000029,
      "HIDKeyboardModifierMappingDst":0x700000039},
     {"HIDKeyboardModifierMappingSrc":0x700000029,
      "HIDKeyboardModifierMappingDst":0x700000039}]
}'
