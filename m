From: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Subject: How to put extra clock cycles on i2c cavinci, problems on omapl138 (logic
 pd som)
Date: Fri, 11 Mar 2011 13:52:55 +0100
Message-ID: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

we have problems with the davinci-i2c driver on an omapl-138 (Logic PD 
SOM) in
conjunction with tps65070 hardware and tps6507x_ts touchscreen driver. 

(The following thread is related to this issue.
http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg21162.html
)

After some action on the touchscreen, there are communication errors
on the i2c, and the bus stalled.
In this state the SDA line is hold low and the driver gives repeatedly
the following messages:

tps6507x 1-0048: ADC result 1 read failed
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
tps6507x 1-0048: TSC mode read failed
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
tps6507x 1-0048: TSC mode read failed
[...]

When giving a short low impulse on the SCL wire by shortcutting
this line with ground, the i2c is running again. 

Under http://processors.wiki.ti.com/index.php/I2C_Tips 
there is article about : External Slave Device Hanging the Bus by
Holding SDA Low

Option 1: For devices that mux the SCL/SDA pins with GPIO, the easiest
thing is to configure the pins for GPIO operation and toggle SCL until
the slave releases SDA. At this point you should be able to resume
normal operation.

Option 2: Many devices don't mux SCL/SDA with GPIO since the I2C I/O
cells are often special open drain cells. A workaround has been
reported to work even on these devices. By configuring the I2C for
"free data format" and then reading a byte the I2C will immediately
start sending clocks to input data (rather than trying to send an
address). This can be used to free up the bus.

We would like to have some extra SCL pulses in the function 
static void i2c_recover_bus(struct davinci_i2c_dev *dev).

We tried to put the I2C in "free data format" and read one byte with
the following lines:

            flag |= DAVINCI_I2C_MDR_FDF;// free data format mode
            flag &= ~DAVINCI_I2C_MDR_TRX;// receive byte
            // Set STT to begin transmit now DXR is loaded
            flag |= DAVINCI_I2C_MDR_STT;
            davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag); 

But that doesn`t work that way.

We have problems to use the GPIO variant to toggle SCL or using the 
generic_i2c_clock_pulse function, too.

Please tell me how to get extra clock cycles on i2c?

Thank you, regards,

Bastian Ruppert.

P.S.

[please put me on cc, i am not on the vger.kernel.org list, thx] 
