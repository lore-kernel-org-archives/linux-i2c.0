From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming - solved
Date: Wed, 11 Mar 2015 21:55:51 -0700
Message-ID: <1426136151.37151.YahooMailNeo@web181506.mail.ne1.yahoo.com>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
Reply-To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426133507.16219.YahooMailNeo-XYahOdtEMNm2Y7dhQGSVAJOW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I tried some random things and setting aliases in the dtsi file solved the problem. The use of an alias to set the name of an i2c bus should be documented somewhere!

<dtsi file fragment>

/ {
    aliases {
        i2c10 = &im0;
        i2c11 = &im1;
        i2c12 = &im2;
        i2c13 = &im3;
        i2c14 = &im4;
        i2c15 = &im5;
        i2c16 = &im6;
        i2c17 = &im7;
    };
};

&i2c0 {
    status = "okay";
};

&i2c2 {
    status = "okay";
    i2cmux@77 {
         compatible = "nxp,pca9548";
         #address-cells = <1>;
         #size-cells = <0>;
         reg = <0x77>;

 im0:    i2c-bus-0 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <0>;
        };
 im1:    i2c-bus-1 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <1>;
        };
 im2:    i2cm@2 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <2>;
        };
 im3:    i2cm@3 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <3>;
        };
 im4:    i2cm@4 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <4>;
        };
 im5:    i2cm@5 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <5>;
        };
 im6:    i2cm@6 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <6>;
        };
 im7:    i2cm@7 {
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <7>;
        };
     };
};


*** Interactive commands   *****
ubuntu@arm:~$ ls /dev/i2c*
/dev/i2c-0   /dev/i2c-11  /dev/i2c-13  /dev/i2c-15  /dev/i2c-17
/dev/i2c-10  /dev/i2c-12  /dev/i2c-14  /dev/i2c-16  /dev/i2c-2
ubuntu@arm:~$ i2cdetect -l
i2c-0    i2c           OMAP I2C adapter                    I2C adapter
i2c-2    i2c           OMAP I2C adapter                    I2C adapter
i2c-10    i2c           i2c-2-mux (chan_id 0)               I2C adapter
i2c-11    i2c           i2c-2-mux (chan_id 1)               I2C adapter
i2c-12    i2c           i2c-2-mux (chan_id 2)               I2C adapter
i2c-13    i2c           i2c-2-mux (chan_id 3)               I2C adapter
i2c-14    i2c           i2c-2-mux (chan_id 4)               I2C adapter
i2c-15    i2c           i2c-2-mux (chan_id 5)               I2C adapter
i2c-16    i2c           i2c-2-mux (chan_id 6)               I2C adapter
i2c-17    i2c           i2c-2-mux (chan_id 7)               I2C adapter
ubuntu@arm:~$ ls /sys/bus/i2c/devices
0-0024  0-0050  2-0054  2-0056  2-0077  i2c-10  i2c-12  i2c-14  i2c-16  i2c-2
0-0034  0-0070  2-0055  2-0057  i2c-0   i2c-11  i2c-13  i2c-15  i2c-17

Regards,
Bob Feretich



----- Original Message -----
From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>; Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>; Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Sent: Wednesday, March 11, 2015 9:11 PM
Subject: Another problem with I2C multiplexer bus naming

I am working on a BeagleBone Black (BBB) Cape that contains a PCA9548 multiplexer (mux). The BBB uses two I2C buses, i2c-0 for power management and i2c-2 for Cape discovery and other general use. I have created a dtsi file to describe the mux on my Cape per the Linux Documentation instructions. 


...

&i2c2 {
    i2cmux@77 {
         compatible = "nxp,pca9548";
         #address-cells = <1>;
         #size-cells = <0>;
         reg = <0x77>;
};
...

When I boot Linux (3.14 kernel) without the cape attached I see i2c-0 and i2c-2...
ubuntu@arm:~$ ls /dev/i2* 
/dev/i2c-0  /dev/i2c-2
ubuntu@arm:~$ i2cdetect -l
i2c-0    i2c           OMAP I2C adapter                    I2C adapter
i2c-2    i2c           OMAP I2C adapter                    I2C adapter

But, I can also see in dmesg that i2c-0 probing is deferred until after i2c-2.
[    2.186756] omap_i2c 44e0b000.i2c: could not find pctldev for node /pinmux@44e10800/pinmux_i2c0_pins, deferring probe
[    2.186803] platform 44e0b000.i2c: Driver omap_i2c requests probe deferral
[    2.193949] omap_i2c 4819c000.i2c: bus 2 rev0.11 at 100 kHz
...snipped...
[    2.965899] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    2.967376] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
[    2.967500] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz


This causes a problem when I boot with the Cape attached.
1) Probing is deferred on i2c-0.
2) i2c-2 is probed, the mux is discovered, and the child buses are 

    assigned i2c-0, i2c-1, and i2c-3 through i2c-8.
3) The original i2c-0 bus is then probed, but since it requires the name i2c-0 and that name is already used, adapter addition fails.

ubuntu@arm:~$ ls /dev/i2* 
/dev/i2c-0  /dev/i2c-2  /dev/i2c-4  /dev/i2c-6  /dev/i2c-8
/dev/i2c-1  /dev/i2c-3  /dev/i2c-5  /dev/i2c-7
ubuntu@arm:~$ i2cdetect -l
i2c-0    i2c           i2c-2-mux (chan_id 0)               I2C adapter
i2c-1    i2c           i2c-2-mux (chan_id 1)               I2C adapter
i2c-2    i2c           OMAP I2C adapter                    I2C adapter
i2c-3    i2c           i2c-2-mux (chan_id 2)               I2C adapter
i2c-4    i2c           i2c-2-mux (chan_id 3)               I2C adapter
i2c-5    i2c           i2c-2-mux (chan_id 4)               I2C adapter
i2c-6    i2c           i2c-2-mux (chan_id 5)               I2C adapter
i2c-7    i2c           i2c-2-mux (chan_id 6)               I2C adapter
i2c-8    i2c           i2c-2-mux (chan_id 7)               I2C adapter


>From dmesg...
[    2.186754] omap_i2c 44e0b000.i2c: could not find pctldev for node /pinmux@44e10800/pinmux_i2c0_pins, deferring probe
[    2.186802] platform 44e0b000.i2c: Driver omap_i2c requests probe deferral
[    2.193953] omap_i2c 4819c000.i2c: bus 2 rev0.11 at 100 kHz
...snipped...
[    2.753254] i2c /dev entries driver
[    2.756232] i2c i2c-2: Added multiplexed i2c bus 0
[    2.756992] i2c i2c-2: Added multiplexed i2c bus 1
[    2.757690] i2c i2c-2: Added multiplexed i2c bus 3
[    2.758361] i2c i2c-2: Added multiplexed i2c bus 4
[    2.759065] i2c i2c-2: Added multiplexed i2c bus 5
[    2.759717] i2c i2c-2: Added multiplexed i2c bus 6
[    2.760392] i2c i2c-2: Added multiplexed i2c bus 7
[    2.761065] i2c i2c-2: Added multiplexed i2c bus 8
[    2.761081] pca954x 2-0077: registered 8 multiplexed busses for I2C switch 

...snipped...
[    2.951717] omap_i2c 44e0b000.i2c: failure adding adapter
...snipped...
[    2.964249] omap_i2c: probe of 44e0b000.i2c failed with error -16
... snipped ...
[    8.997764] cpu cpu0: of_pm_voltdm_notifier_register: Failed to get cpu0 regulator/voltdm: -517
[    8.997796] cpu cpu0: cpu0 clock notifier not ready, retry
[    9.082435] platform cpufreq-cpu0.0: Driver cpufreq-cpu0 requests probe deferral
[    9.194548] slave hdmi.38: could not get i2c  


Is there a quick work-around for this problem (prevent deferred probing or defer both bus probes)?

Is there a way that I can force the child buses to use names that don't conflict with BBB predefined buses (perhaps a property or alias in the device tree)?

Will the future "multiple i2c multiplexers on the same bus" solution fix this problem?

Any other ideas for a work around?

Regards, 

Bob Feretich
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
