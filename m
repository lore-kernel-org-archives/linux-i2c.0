From: Michael Berger <mikeaberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Unable to access I2C device behind two muxes configured to deselect.
Date: Wed, 17 Jun 2015 08:23:45 -0400
Message-ID: <CAArnDZ=WNAOHzxxPPfW+=OLgE6oSifsjWo9qu++Jo+5T4CA_xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I cannot access an I2C device located behind two or more nested
PCA9545 muxes if the muxes are configured to use a deselect function.

I'm not sure whether this is a bug in i2c-mux.c, i2c-mux-pca954x.c,
the interaction between the two, or whether it's a quirk of my
particular hardware.  I'm hoping someone more familiar with the
subsystem can provide some guidance.

I'm using Linux Version 3.18.14 on a Cavium Octeon II.

I have an I2C bus that has two PCA9545 muxes at addresses 0x71 and
0x72.  Channel 3 of both of the muxes has another PCA9545 at address
0x70.  There is an at24 EEPROM with address 0x50 on each channel of
the lower muxes.  I put a DT description of the topology at the end of
this post.

Since the topology behind each of the top muxes fronts the same I2C
addressing, I have to configure each of the top PCA9545's to use the
deselect function.  For completeness, I also configure the bottom
PCA9545's to use the deselect function.

I investigated by connecting an I2C analyzer to my bus to verify what
I'm seeing "on the wire".

When I have all the PCA9545 muxes configured to use the deselect
function, I see the following on the bus when trying to read one of
the EEPROMs.

Address 0x71 Write 0x08 (select chan 3 of the upper mux)
Address 0x70 Write 0x04 (select chan 2 of the lower mux)
Address 0x71 Write 0x00 (deselect upper mux)
Address 0x71 Write 0x08 (select chan 3 of the upper mux AGAIN - this
should make everything good, but the branch is wedged.)
Address 0x50 --- At this point I see an error/NACK with the SDA
floating high and the SCLK staying low.  I would have thought that the
second write of 0x08 to address 0x71 would (re-)select the correct
path through the top mux, but that isn't happening and I don't have a
good explanation for it.  This behaviour is 100% reproducible on my
system.

When I configure the all the PCA9545 muxes with NO deselect function,
which is the default for the driver, I see the following when trying
to read the same EEPROM and after I've made sure that the other upper
PCA9545 has been deselected.

Address 0x71 Write 0x08 (select chan 3 of the upper mux)
Address 0x70 Write 0x04 (select chan 2 of the lower mux)
Address 0x71 Write 0x08 (select chan 3 of the upper mux AGAIN)
Address 0x50 Write 0x00 (start reading EEPROM at offset 0)
Address 0x50 Read 0x0d (first byte)
             ....
             Read 0x00 (128th byte read)

Note that the read operation fails with undefined behaviour if I do
not manually make sure the other top PCA9545 is deselected which is
why I want the muxes to be deselected in the first place.

Note also that the 'deselect' configuration does work properly for me
when I access a device that is behind only one mux rather than two -
i.e. the eeprom@52 in the DT below.

-------------------------------------------------------------------------------

Below is a function-graph ftrace of the case with NO deselect. Lines
beginning with '##' are my own annotations.

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
## Called from at24_read_eeprom()
 0)               |  msecs_to_jiffies() {
 0)   5.497 us    |  } /* msecs_to_jiffies */
 0)               |  i2c_transfer() {
 0)               |    i2c_lock_adapter() {
 0)               |      rt_mutex_lock() {
 0)               |        _cond_resched() {
 0)   1.097 us    |        } /* _cond_resched */
 0)   3.242 us    |      } /* rt_mutex_lock */
 0)   6.078 us    |    } /* i2c_lock_adapter */
 0)               |    __i2c_transfer() {
 0)               |      /* 2041: adap=16 READ addr=50 off=00 len=128 */
 0)               |      i2c_mux_master_xfer() {
 0)               |        /* i2c_mux_master_xfer:51 adap=16 parent=13
num=2 addr=50 val=00 */
 0)               |        pca954x_select_chan() {
 0)               |          /* 161: adap=13 addr=70 chan=2 */
 0)               |          pca954x_reg_write() {
 0)               |            /* 137: adap=13 addr=70 val=4 */
 0)               |            i2c_mux_master_xfer() {
 0)               |              /* i2c_mux_master_xfer:51 adap=13
parent=1 num=1 addr=70 val=04 */
 0)               |              pca954x_select_chan() {
 0)               |                /* 161: adap=1 addr=71 chan=3 */
 0)               |                pca954x_reg_write() {
 0)               |                  /* 137: adap=1 addr=71 val=8 */
 0)               |                  octeon_i2c_xfer() {
 0)               |                    /* octeon_i2c_xfer: Select
adap=1 addr=71 val=08 */
 ## On the wire: addr 0x71 write data 0x08
 0) ! 250.668 us  |                  } /* octeon_i2c_xfer */
 0) ! 255.498 us  |                } /* pca954x_reg_write */
 0) ! 260.023 us  |              } /* pca954x_select_chan */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=70 val=04 */
 ## On the wire: addr 0x70 write data 0x04
 0) ! 245.471 us  |              } /* octeon_i2c_xfer */
 0) ! 512.298 us  |            } /* i2c_mux_master_xfer */
 0) ! 516.573 us  |          } /* pca954x_reg_write */
 0) ! 521.790 us  |        } /* pca954x_select_chan */
 0)               |        i2c_mux_master_xfer() {
 0)               |          /* i2c_mux_master_xfer:51 adap=13
parent=1 num=2 addr=50 val=00 */
 0)               |          pca954x_select_chan() {
 0)               |            /* 161: adap=1 addr=71 chan=3 */
 0)               |            pca954x_reg_write() {
 0)               |              /* 137: adap=1 addr=71 val=8 */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=71 val=08 */
 ## On the wire: addr 0x71 write data 0x08
 0) ! 243.341 us  |              } /* octeon_i2c_xfer */
 0) ! 247.904 us  |            } /* pca954x_reg_write */
 0) ! 252.087 us  |          } /* pca954x_select_chan */
 0)               |          octeon_i2c_xfer() {
 0)               |            /* octeon_i2c_xfer: READ adap=1 addr=50
off=0 len=128 */
 0) ! 18475.10 us |          } /* octeon_i2c_xfer */
 ## On the wire: addr 0x50 WRITE offset=0x00
 ## On the wire: addr 0x50 READ length=0x80 bytes
 0) ! 18735.35 us |        } /* i2c_mux_master_xfer */
 0) ! 19263.97 us |      } /* i2c_mux_master_xfer */
 0) ! 19273.14 us |    } /* __i2c_transfer */
 0)               |    i2c_unlock_adapter() {
 0)               |      rt_mutex_unlock() {
 0)   1.129 us    |      } /* rt_mutex_unlock */
 0)   3.886 us    |    } /* i2c_unlock_adapter */
 0) ! 19288.22 us |  } /* i2c_transfer */

-------------------------------------------------------------------------------

Below is a function-graph ftrace of the case with deselect configured.
Lines beginning with '##' are my own annotations.

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  msecs_to_jiffies() {
 0)   5.507 us    |  } /* msecs_to_jiffies */
 0)               |  i2c_transfer() {
 0)               |    i2c_lock_adapter() {
 0)               |      rt_mutex_lock() {
 0)               |        _cond_resched() {
 0)   1.051 us    |        } /* _cond_resched */
 0)   3.197 us    |      } /* rt_mutex_lock */
 0)   6.039 us    |    } /* i2c_lock_adapter */
 0)               |    __i2c_transfer() {
 0)               |      /* 2041: adap=16 READ addr=50 off=00 len=128 */
 0)               |      i2c_mux_master_xfer() {
 0)               |        /* i2c_mux_master_xfer:51 adap=16 parent=13
num=2 addr=50 val=00 */
 0)               |        pca954x_select_chan() {
 0)               |          /* 161: adap=13 addr=70 chan=2 */
 0)               |          pca954x_reg_write() {
 0)               |            /* 137: adap=13 addr=70 val=4 */
 0)               |            i2c_mux_master_xfer() {
 0)               |              /* i2c_mux_master_xfer:51 adap=13
parent=1 num=1 addr=70 val=04 */
 0)               |              pca954x_select_chan() {
 0)               |                /* 161: adap=1 addr=71 chan=3 */
 0)               |                pca954x_reg_write() {
 0)               |                  /* 137: adap=1 addr=71 val=8 */
 0)               |                  octeon_i2c_xfer() {
 0)               |                    /* octeon_i2c_xfer: Select
adap=1 addr=71 val=08 */
 ## On the wire: addr 0x71 write data 0x08
 0) ! 250.025 us  |                  } /* octeon_i2c_xfer */
 0) ! 255.012 us  |                } /* pca954x_reg_write */
 0) ! 259.538 us  |              } /* pca954x_select_chan */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=70 val=04 */
 ## On the wire: addr 0x70 write data 0x04
 0) ! 244.511 us  |              } /* octeon_i2c_xfer */
 0)               |              pca954x_deselect_mux() {
 0)               |                /* 188: adap=1 addr=71 chan=3 */
 0)               |                pca954x_reg_write() {
 0)               |                  /* 137: adap=1 addr=71 val=0 */
 0)               |                  octeon_i2c_xfer() {
 0)               |                    /* octeon_i2c_xfer: Select
adap=1 addr=71 val=00 */
 ## On the wire: addr 0x71 write data 0x00
 0) ! 243.237 us  |                  } /* octeon_i2c_xfer */
 0) ! 247.821 us  |                } /* pca954x_reg_write */
 0) ! 252.456 us  |              } /* pca954x_deselect_mux */
 0) ! 764.564 us  |            } /* i2c_mux_master_xfer */
 0) ! 768.799 us  |          } /* pca954x_reg_write */
 0) ! 773.785 us  |        } /* pca954x_select_chan */
 0)               |        i2c_mux_master_xfer() {
 0)               |          /* i2c_mux_master_xfer:51 adap=13
parent=1 num=2 addr=50 val=00 */
 0)               |          pca954x_select_chan() {
 0)               |            /* 161: adap=1 addr=71 chan=3 */
 0)               |            pca954x_reg_write() {
 0)               |              /* 137: adap=1 addr=71 val=8 */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=71 val=08 */
 ## On the wire: addr 0x71 write data 0x08
 0) ! 243.896 us  |              } /* octeon_i2c_xfer */
 0) ! 248.465 us  |            } /* pca954x_reg_write */
 0) ! 252.740 us  |          } /* pca954x_select_chan */
 0)               |          octeon_i2c_xfer() {
 0)               |            /* octeon_i2c_xfer: READ adap=1 addr=50
off=0 len=128 */
 ## On the wire: addr 0x50 WRITE offset=0x00 - this is NACK/Timeout on hardware
 ## On the wire: addr 0x50 READ length=0x80 bytes - this never makes
it to the wire.
 0) ! 92821.93 us |          } /* octeon_i2c_xfer */
 0)               |          pca954x_deselect_mux() {
 0)               |            /* 188: adap=1 addr=71 chan=3 */
 0)               |            pca954x_reg_write() {
 0)               |              /* 137: adap=1 addr=71 val=0 */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=71 val=00 */
 0) ! 253.754 us  |              } /* octeon_i2c_xfer */
 0) ! 258.924 us  |            } /* pca954x_reg_write */
 0) ! 263.979 us  |          } /* pca954x_deselect_mux */
 0) ! 93347.76 us |        } /* i2c_mux_master_xfer */
 0)               |        pca954x_deselect_mux() {
 0)               |          /* 188: adap=13 addr=70 chan=2 */
 0)               |          pca954x_reg_write() {
 0)               |            /* 137: adap=13 addr=70 val=0 */
 0)               |            i2c_mux_master_xfer() {
 0)               |              /* i2c_mux_master_xfer:51 adap=13
parent=1 num=1 addr=70 val=00 */
 0)               |              pca954x_select_chan() {
 0)               |                /* 161: adap=1 addr=71 chan=3 */
 0)               |                pca954x_reg_write() {
 0)               |                  /* 137: adap=1 addr=71 val=8 */
 0)               |                  octeon_i2c_xfer() {
 0)               |                    /* octeon_i2c_xfer: Select
adap=1 addr=71 val=08 */
 0) ! 244.313 us  |                  } /* octeon_i2c_xfer */
 0) ! 249.100 us  |                } /* pca954x_reg_write */
 0) ! 253.257 us  |              } /* pca954x_select_chan */
 0)               |              octeon_i2c_xfer() {
 0)               |                /* octeon_i2c_xfer: Select adap=1
addr=70 val=00 */
 0) ! 244.218 us  |              } /* octeon_i2c_xfer */
 0)               |              pca954x_deselect_mux() {
 0)               |                /* 188: adap=1 addr=71 chan=3 */
 0)               |                pca954x_reg_write() {
 0)               |                  /* 137: adap=1 addr=71 val=0 */
 0)               |                  octeon_i2c_xfer() {
 0)               |                    /* octeon_i2c_xfer: Select
adap=1 addr=71 val=00 */
 0) ! 243.095 us  |                  } /* octeon_i2c_xfer */
 0) ! 247.709 us  |                } /* pca954x_reg_write */
 0) ! 254.068 us  |              } /* pca954x_deselect_mux */
 0) ! 759.438 us  |            } /* i2c_mux_master_xfer */
 0) ! 763.746 us  |          } /* pca954x_reg_write */
 0) ! 768.899 us  |        } /* pca954x_deselect_mux */
 0) ! 94898.53 us |      } /* i2c_mux_master_xfer */
 0) ! 94908.12 us |    } /* __i2c_transfer */
 0)               |    i2c_unlock_adapter() {
 0)               |      rt_mutex_unlock() {
 0)   1.238 us    |      } /* rt_mutex_unlock */
 0)   3.740 us    |    } /* i2c_unlock_adapter */
 0) ! 94923.00 us |  } /* i2c_transfer */

-------------------------------------------------------------------------------

The i2c_mux_master_xfer() does not seem quite right to me and I don't
see how it could ever correctly deselect nested PCA954x muxes since
the PCA954x drivers recursively call i2c_mux_master_xfer() to select
the correct channels along the nested mux branch.  This has the effect
of selecting the channels through the branch from top to bottom, which
is correct.  However, it will also deselect the muxes from top to
bottom which is not correct.

-------------------------------------------------------------------------------

A DT description of the problem topology (omitting non-relavant
devices) is as follows.

/dts-v1/;
/ {
    soc@0 {
        twsi1: i2c@1180000001200 {
            i2c-switch@71 {
                compatible = "nxp,pca9545";
                reg = <0x71>;
                #address-cells = <1>;
                #size-cells = <0>;

                i2c@0 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <0>;

                    eeprom@52 {
                        compatible = "at,24c02";
                        reg = <0x52>;
                    };
                };

                i2c@3 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <3>;

                    i2c-switch@70 {
                        compatible = "nxp,pca9545";
                        reg = <0x70>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        i2c@0 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <0>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@1 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <1>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@2 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <2>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@3 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <3>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };
                    };
                };
            };
            i2c-switch@71 {
                compatible = "nxp,pca9545";
                reg = <0x71>;
                #address-cells = <1>;
                #size-cells = <0>;

                i2c@3 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <3>;

                        i2c@0 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <0>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@1 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <1>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@2 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <2>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };

                        i2c@3 {
                            #address-cells = <1>;
                            #size-cells = <0>;
                            reg = <3>;

                            eeprom@50 {
                                compatible = "at,24c02";
                                reg = <0x50>;
                            };
                        };
                    };
                };
            };
        };
   };
