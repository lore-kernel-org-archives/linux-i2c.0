From: Elyas Razzaghi <elyas.r-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Add I2C with PCA9665
Date: Fri, 28 Jun 2013 22:47:26 +0300
Message-ID: <CANUwh5TuqK8G_H2HJ3RLBJqvCLvtL0oasbfHvDYJhAMJVgy6yw@mail.gmail.com>
References: <51CD64D5.60907@gmail.com>
	<20130628104516.GC2948@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130628104516.GC2948@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Thanks a lot Wolfram for the hint. I have added the mapping configs:

#if defined (CONFIG_I2C_PCA_PLATFORM) || defined(CONFIG_I2C_ALGOPCA)


static struct resource i2c_resources[] = {
    [0] = {
        .start    = AT91_CHIPSELECT_2,    /* 0x30000000 */
        .end    = AT91_CHIPSELECT_2 + SZ_16K - 1,
        .flags    = IORESOURCE_MEM | IORESOURCE_MEM_8BIT,

    },
    [1] = {
        .start    = AT91RM9200_ID_IRQ0,
        .end    = AT91RM9200_ID_IRQ0,
        .flags    = IORESOURCE_IRQ,
    },
};

static struct i2c_pca9564_pf_platform_data pca9665_platform_data = {
    .gpio        = AT91_PIN_PB27,
    .i2c_clock_speed= 400000,

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

static struct i2c_board_info __initdata ek_i2c_devices[] = {
    {
        I2C_BOARD_INFO("lm75", 0x48),
    },
    {
        I2C_BOARD_INFO("pcf8523", 0x68),
    },
};

void __init at91_add_device_i2c_pca(struct i2c_board_info *devices,
int nr_devices)

{
    at91_set_A_periph(AT91_PIN_PB29, 1);        /* IRQ0 interrupt pin */

    /* Initialization of the Static Memory Controller for Chip Select 2 */
    at91_ramc_write(0, AT91_SMC_CSR(2), AT91_SMC_ACSS_STD
        | AT91_SMC_DBW_8    /* 8 bit */
        | AT91_SMC_WSEN        /* Wait State Enable */
    );

    i2c_register_board_info(0, devices, nr_devices);
    platform_device_register(&pca9665_twi_device);
}

#endif

 And now the correct controller is detected:

# dmesg | grep PCA
PCA9564/PCA9665 at 0x30000000: PCA9665 detected.
PCA9564/PCA9665 at 0x30000000: Clock frequency is 400000Hz
PCA9564/PCA9665 at 0x30000000 registered.

The i2c devices are also detected:

# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Best regards,
Elyas

On Fri, Jun 28, 2013 at 1:45 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> static struct resource i2c_resources[] = {
>>     [0] = {
>>         .start    = AT91_CHIPSELECT_2,    /* 0x30000000 */
>>         .end    = AT91_CHIPSELECT_2 + SZ_16K - 1,
>>         .flags    = IORESOURCE_MEM,
>
> Unless reading 0x30000000 does not return something like 0xf8, you have
> a problem with mapping in the register range. Make sure the, 8 bit bus
> width works.
>
> Regards,
>
>    Wolfram
>
