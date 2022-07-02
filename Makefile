CONFIGS=i3 sway
ifeq (${KEYMAP}, us)
_KEYMAP=-Dm4_us
endif
all: ${CONFIGS}

i3: i3.sample 
	m4 -P -Dm4_i3 ${_KEYMAP} i3.sample > i3
sway: i3.sample
	m4 -P -Dm4_sway ${_KEYMAP} i3.sample > sway
install:
	for file in ${CONFIGS};do \
		[ -e $$file ] && \
	        ln -sf $$(realpath -e $$file) ~/.config/$$file/config; \
	done
clean:
	rm ${CONFIGS}
.PHONY: all install clean
