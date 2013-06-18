From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: i2c core: issue in of_i2c_register_devices()
Date: Tue, 18 Jun 2013 16:52:16 +0200
Message-ID: <51C07420.1010306@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I think I have a corner case and I don't immediately see how to solve
the issue.

On the cfa-10049, we have 3 nau7802 ADCs. As they are sharing the same
address,  they are behind a gpio based i2c muxer.

Those ADCs are able to send interrupts. So, the interrupts lines are
connected to a pca9555 which is behind the same i2c muxer.


                                           +--------------+
                                           |              |<-------+ V1
                                       +---+ nau7802      |
            +-----------------+        |   |             
+---IRQ--------------+
     i2c0+--+                 |        |  
+--------------+                    |
            |                 |       
|                                       |
            |  gpio i2c muxer +--i2c---+  
+--------------+                    |
     gpios+-+                 |        |   |              |<-------+
V2        |
            |                 |        +---+ nau7802     
|                    |
            +-----------------+        |   |             
+---IRQ----------+   |
                                       |  
+--------------+                |   |
                                      
|                                   |   |
                                       |  
+--------------+                |   |
                                       |   |              |<-------+
V3    |   |
                                       +---+ nau7802     
|                |   |
                                       |   |             
+---IRQ-------+  |   |
                                       |   +--------------+            
|  |   |
                                       |                               
|  |   |
                                       |   +--------------+            
|  |   |
                                       |   |             
|<------------+  |   |
                                       +---|             
|                |   |
                                           | pca9555     
|<---------------+   |
                 IRQ   <-------------------+             
|                    |
                                           |             
|<-------------------+
                                           +--------------+


So, the relevant bits of the DT are:

i2cmux {
        compatible = "i2c-mux-gpio";
        #address-cells = <1>;
        #size-cells = <0>;
        mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
        i2c-parent = <&i2c1gpio>;

        i2c@0 {
            reg = <0>;
            #address-cells = <1>;
            #size-cells = <0>;

            adc0: nau7802@2a {
                compatible = "nuvoton,nau7802";
                reg = <0x2a>;
                nuvoton,vldo = <3000>;
                interrupt-parent = <&pca9555>;
                interrupts = <8 0x2>;
            };
        };

[...]

        i2c@3 {
            reg = <3>;
            #address-cells = <1>;
            #size-cells = <0>;

            pca9555: pca9555@20 {
                compatible = "nxp,pca9555";
                interrupt-parent = <&gpio2>;
                interrupts = <19 0x2>;
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-controller;
                #interrupt-cells = <2>;
                reg = <0x20>;
            };
        };
    };

Now, for the issue, at the time we are registering the ADCs in
of_i2c_register_devices(), using info.irq = irq_of_parse_and_map(node,
0) results in :

irq: no irq domain found for /i2cmux/i2c@3/pca9555@20 !

as the pca9555 is not yet registered. But, it is not possible to move
the pca9555 definition upper in the DT be cause the order seems to be
significant for i2c-mux-gpio. Obviously, if I use irq_of_parse_and_map()
in the probe of the nau7802 driver, it is working fine but that is not a
future proof solution.

How would you suggest to solve that ?

regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
