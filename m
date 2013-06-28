From: Elyas Razzaghi <elyas.r-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Add I2C with PCA9665
Date: Fri, 28 Jun 2013 13:26:29 +0300
Message-ID: <51CD64D5.60907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I am using the PCA9665 controller in my custom board because the 
internal I2C controller of my processor (AT91RM9200) is not robust. The 
following are my configs:

Hardware:

D0 - D7 --> D0 - D7
Write strobe --> NWR0/NWE/CFWE
Read strobe --> NRD/NOE/CFOE
Chip Enable --> NCS2
A0 --> A0/NBS0
A1 --> A1
Interrupt request --> PB29/IRQ0
Reset --> PB27

Software:

static struct resource i2c_resources[] = {
     [0] = {
         .start    = AT91_CHIPSELECT_2,    /* 0x30000000 */
         .end    = AT91_CHIPSELECT_2 + SZ_16K - 1,
         .flags    = IORESOURCE_MEM,
     },
     [1] = {
         .start    = AT91RM9200_ID_IRQ0,
         .end    = AT91RM9200_ID_IRQ0,
         .flags    = IORESOURCE_IRQ,
     },
};

static struct i2c_pca9564_pf_platform_data pca9665_platform_data = {
     .gpio        = AT91_PIN_PB27,
     .i2c_clock_speed= 0,
     .timeout    = HZ,        /* timeout in jiffies */
};

static struct platform_device pca9665_twi_device = {
     .name        = "i2c-pca-platform",
     .id        = -1,
     .dev        = {
                 .platform_data = &pca9665_platform_data,
             },
     .num_resources    = ARRAY_SIZE(i2c_resources),
     .resource    = i2c_resources,
};

void __init at91_add_device_i2c(struct i2c_board_info *devices, int 
nr_devices)
{
     at91_set_A_periph(AT91_PIN_PB29, 1);        /* IRQ0 interrupt pin */
     i2c_register_board_info(0, devices, nr_devices);
     platform_device_register(&pca9665_twi_device);
}

But the board detects the wrong external I2C controller (PCA9564):

# dmesg | grep PCA
PCA9564/PCA9665 at 0x30000000: PCA9564 detected.
PCA9564/PCA9665 at 0x30000000: Choosing the clock frequency based on 
index is deprecated. Use the nominal frequency.
PCA9564/PCA9665 at 0x30000000: Clock frequency is 330kHz
PCA9564/PCA9665 at 0x30000000 registered.

And, the i2c controller is not functional at all. The i2cdetect command 
of i2c-tools package from lm-sensors, does not detect any devices on my 
i2c bus, while there must be two i2c devices (a RTC and a temperature 
sensor) on my board. There is no i2c clock or data signal either on the 
bus using the oscilloscope probe.

How can I fix this so the board detects the functional and correct 
controller (PCA9665)?

Best regards,
Elyas Razzaghi
