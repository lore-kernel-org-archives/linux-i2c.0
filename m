From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.3
Date: Sun, 6 Sep 2015 19:20:03 +0200
Message-ID: <20150906172000.GA1664@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the pull request for i2c. Features:

* new drivers: Renesas EMEV2, register based MUX, NXP LPC2xxx
* core: scans DT and assigns wakeup interrupts. no driver changes needed.
* core: some refcouting issues fixed and better API for that
* core: new helper function for best effort block read emulation
* slave framework: proper DT bindings and userspace instantiation
* some bigger work for xiic, pxa, omap drivers

And quite a number of smaller driver fixes, cleanups, improvements.

Please pull.

Thanks,

   Wolfram


The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.3

for you to fetch changes up to 5a73882fd2c3a86b502d54da532d373a1f2db15e:

  i2c: mux: reg Change ioread endianness for readback (2015-09-03 11:58:42 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: designware-pci: use IRQF_COND_SUSPEND flag

Anurag Kumar Vulisha (1):
      i2c: removed work arounds in i2c driver for Zynq Ultrascale+ MPSoC

Colin Ian King (1):
      i2c: viperboard: clean up inconsistent indenting

Dan Carpenter (1):
      i2c: xgene-slimpro: dma_mapping_error() doesn't return an error code

Denis Carikli (1):
      DT: i2c: Add ADS7828 and ADS7830 to list of trivial devices

Dmitry Torokhov (2):
      of/irq: export of_get_irq_byname()
      i2c: allow specifying separate wakeup interrupt in device tree

Eddie Huang (2):
      i2c: mediatek: Reset DMA engine in hardware init function
      i2c: mediatek: Fixup i2c ack error interrupt handling

Felipe Balbi (3):
      i2c: omap: switch to dev_get_drvdata()
      i2c: omap: abolish variable name confusion
      i2c: omap: on ->remove() call pm_runtime_put_sync()

Irina Tirdea (2):
      i2c: core: Add support for best effort block read emulation
      eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated

Jarkko Nikula (1):
      i2c: designware: Make debug print in i2c_dw_isr() shorter

Javier Martinez Canillas (2):
      misc: eeprom: Export I2C module alias information in missing drivers
      i2c: Replace I2C_CROS_EC_TUNNEL dependency

Joachim Eastwood (1):
      i2c: lpc2k: add driver

Krzysztof Kozlowski (2):
      i2c: Drop owner assignment from i2c_driver
      misc: Drop owner assignment from i2c_driver

Laxman Dewangan (2):
      i2c: tegra: update CONFIG_LOAD for new conifiguration
      i2c: tegra: add support for fast plus (FM+) mode clock rate

Leilei Shang (1):
      i2c: pxa: keep i2c irq ON in suspend

Masahiro Yamada (1):
      i2c: cadence: set THIS_MODULE to the owner of the adapter

Mike Rapoport (1):
      i2c: mux: reg: fix compilation warnings

Ondrej Zary (1):
      i2c: parport: Add VCT-jig adapter

Shouming Wang (1):
      i2c: pxa: Return I2C_RETRY when timeout in pio mode

Shubhrajyoti Datta (8):
      i2c: xiic: Remove the disabling of interrupts
      i2c: xiic: move the xiic_process to thread context
      i2c: xiic: Do not reset controller before every transfer
      i2c: xiic: Remove the disabling of interrupts
      i2c: xiic: Remove busy loop while waiting for bus busy
      i2c: xiic: Remove the Addressed as slave interrupt
      i2c: xiic: Service all interrupts in isr
      i2c: xiic: Do not continue in case of errors in Rx

Sudip Mukherjee (2):
      i2c: parport: use dev_*
      i2c: parport: start using pr_fmt

Vaibhav Hiremath (3):
      i2c: pxa: No need to set slave addr for i2c master mode reset
      i2c: pxa: Update debug function to dump more info on error
      i2c: pxa: Use devm_ variants in probe function

Vladimir Zapolskiy (4):
      i2c: core: manage i2c bus device refcount in i2c_[get|put]_adapter
      i2c: core: add and export of_get_i2c_adapter_by_node() interface
      i2c: arb-gpio-challenge: use of_get_i2c_adapter_by_node interface
      i2c: muxes: fix leaked i2c adapter device node references

Wolfram Sang (18):
      clk: shmobile: emev2: deassert reset for IIC0/1
      i2c: emev2: add driver
      i2c: omap: fix cleanup regression
      rtc: bq32k: move binding docs to proper place
      hwmon: max6697: move binding docs to proper place
      hwmon: ina2xx: move binding docs to proper place
      hwmon: ina209: move binding docs to proper place
      dt-bindings: add header for generic I2C flags in bindings
      i2c: add a flag to mark clients as slaves
      i2c: apply address offset for slaves, too
      i2c: rename address check functions
      i2c: make address check indpendent from client struct
      i2c: apply DT flags when probing
      i2c: take address space into account when checking for used addresses
      i2c: support 10 bit and slave addresses in sysfs 'new_device'
      i2c: slave: print warning if slave flag not set
      i2c: dt: describe generic bindings
      i2c: mux: reg: simplify register size checking

Yipeng Yao (1):
      i2c: pxa: Fix compile warning in 64bit mode

York Sun (2):
      i2c: mux: Add register-based mux i2c-mux-reg
      i2c: mux: reg Change ioread endianness for readback

 .../devicetree/bindings/{i2c => hwmon}/ina209.txt  |   0
 .../devicetree/bindings/{i2c => hwmon}/ina2xx.txt  |   0
 .../devicetree/bindings/{i2c => hwmon}/max6697.txt |   0
 .../devicetree/bindings/i2c/i2c-cadence.txt        |   6 +-
 .../devicetree/bindings/i2c/i2c-emev2.txt          |  22 +
 .../devicetree/bindings/i2c/i2c-lpc2k.txt          |  33 ++
 .../devicetree/bindings/i2c/i2c-mux-reg.txt        |  74 +++
 Documentation/devicetree/bindings/i2c/i2c.txt      |  45 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 .../devicetree/bindings/{i2c => rtc}/ti,bq32k.txt  |   0
 Documentation/i2c/busses/i2c-parport               |   1 +
 Documentation/i2c/slave-interface                  |   9 +-
 Documentation/i2c/ten-bit-addresses                |   4 +
 drivers/clk/shmobile/clk-emev2.c                   |   6 +
 drivers/i2c/busses/Kconfig                         |  19 +-
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-cadence.c                   |  69 ++-
 drivers/i2c/busses/i2c-designware-core.c           |   3 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   4 +-
 drivers/i2c/busses/i2c-emev2.c                     | 332 ++++++++++++
 drivers/i2c/busses/i2c-lpc2k.c                     | 513 ++++++++++++++++++
 drivers/i2c/busses/i2c-mt65xx.c                    |  21 +-
 drivers/i2c/busses/i2c-omap.c                      | 600 ++++++++++-----------
 drivers/i2c/busses/i2c-parport.c                   |  25 +-
 drivers/i2c/busses/i2c-parport.h                   |   8 +
 drivers/i2c/busses/i2c-pxa.c                       | 112 ++--
 drivers/i2c/busses/i2c-tegra.c                     |  52 +-
 drivers/i2c/busses/i2c-viperboard.c                |  10 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |   8 +-
 drivers/i2c/busses/i2c-xiic.c                      |  74 ++-
 drivers/i2c/i2c-core.c                             | 229 ++++++--
 drivers/i2c/i2c-slave-eeprom.c                     |   1 -
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |   3 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   1 +
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   1 -
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   1 -
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |   1 +
 drivers/i2c/muxes/i2c-mux-reg.c                    | 290 ++++++++++
 drivers/misc/ad525x_dpot-i2c.c                     |   1 -
 drivers/misc/apds990x.c                            |   1 -
 drivers/misc/bh1770glc.c                           |   1 -
 drivers/misc/bmp085-i2c.c                          |   1 -
 drivers/misc/eeprom/at24.c                         |  38 +-
 drivers/misc/eeprom/max6875.c                      |   1 +
 drivers/misc/isl29003.c                            |   1 -
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 -
 drivers/misc/ti-st/st_kim.c                        |   1 -
 drivers/misc/tsl2550.c                             |   1 -
 drivers/of/irq.c                                   |   1 +
 include/dt-bindings/i2c/i2c.h                      |  18 +
 include/linux/i2c.h                                |  19 +-
 include/linux/platform_data/i2c-mux-reg.h          |  44 ++
 54 files changed, 2189 insertions(+), 533 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina209.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-emev2.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c.txt
 rename Documentation/devicetree/bindings/{i2c => rtc}/ti,bq32k.txt (100%)
 create mode 100644 drivers/i2c/busses/i2c-emev2.c
 create mode 100644 drivers/i2c/busses/i2c-lpc2k.c
 create mode 100644 drivers/i2c/muxes/i2c-mux-reg.c
 create mode 100644 include/dt-bindings/i2c/i2c.h
 create mode 100644 include/linux/platform_data/i2c-mux-reg.h

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV7HW/AAoJEBQN5MwUoCm2oxIP/RRw2e0uG2YMecnSX6h8LgfY
jrSwSsh3ue4kznXmW/tbkKBZ7afjqkh/CKNuKChn7v8HB24nsNkHRJRkR4RrLl6Z
600/3THjPRc3mhLfzs0fmzQNLZxOIL5/r5dUK0+cfnNrYI+NwbgyAasVni1SC5EN
s8bLybxR0ypZuvLiZilgxR+XzVVY4Dz02pf1wjZc3dek8yb4s4Sn8siAJMOGNOPH
OqDluSXhUHD7VfKWjl2xyFoDm6nvGTggV8XF8MBw4iS5oQyXYBEpi8PIgyRJxW9W
zpwQIRQoHtQX5q4klDE8xlg2aLq0NFw6rryC2s9LTc9Hh7GFT9wNQkZS9IeN9auv
uK3OgjgFJwqa3f3Wd8HupU+20llGlCjD0TPpkW3abuOksG9doeA5maAKzQ4tB4iI
eFAk+6C34zS1ISGJddLMFGDE9Es4Qb24whOzL67jLx9+W1aZrgshVD+2ayDDVT+O
1mKSipgM2UTjyX5BmdcXcWWMoPedC2xUKQ9dpN3dnFTLBYnU249GD/RiEVSAAECW
+0kTUIcHyCIcTMetNpOv52umubwLEA0sVxiqyus35r5bblkvazz5DNWXmvvU6/2j
rhqZqJaNWxWPUU2pk55g6ziQea9HwFa2Zc2p6UAkjasNwNeVpgvfaWYOamecb34z
XvBLtlFUcL0pXcK/LF4h
=UkDH
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
