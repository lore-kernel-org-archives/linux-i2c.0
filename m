From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Warning with gpio-i2cmux
Date: Fri, 22 Apr 2011 15:46:43 +0200
Message-ID: <20110422154643.60fcfda3@endymion.delvare>
References: <20110419172501.5f37e46f@endymion.delvare>
 <87d3kitf2b.fsf@thor.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d3kitf2b.fsf-1Ae4nN3xCbAluPl5bxqUMw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Thanks for the fast reply.

On Tue, 19 Apr 2011 17:51:24 +0200, Peter Korsgaard wrote:
> >>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> 
> Hi,
> 
> JD> I presume you are using gpio-i2cmux on some of your systems? I tried to
> JD> use it and I get the following warning when I rmmod the underlying I2C
> JD> controller driver:
> 
> Pulling the rug under the driver is not something I normally do, but it
> should work.
> 
> JD> WARNING: at drivers/base/core.c:143 device_release+0x82/0x90()
> JD> Hardware name: System Product Name
> JD> Device 'gpio-i2cmux.0' does not have a release() function, it is broken and must be fixed.
> JD> Modules linked in: i2c_mux i2c_i801(-) jc42 snd_pcm_oss
> JD> snd_mixer_oss snd_seq w83795 snd_seq_device coretemp edd nfsd lockd
> JD> nfs_acl auth_rpcgss sunrpc cpufreq_conservative cpufreq_userspace
> JD> cpufreq_powersave acpi_cpufreq mperf fuse nls_utf8 loop dm_mod
> JD> mt2060 dvb_usb_dib0700 snd_hda_codec_hdmi dib7000p
> JD> snd_hda_codec_realtek dib0090 dib7000m dib0070 snd_hda_intel
> JD> ir_lirc_codec dvb_usb snd_hda_codec lirc_dev dib8000 ir_sony_decoder
> JD> ir_jvc_decoder dvb_core snd_hwdep ir_rc6_decoder ir_rc5_decoder
> JD> snd_pcm dib3000mc ir_nec_decoder rc_core snd_timer ioatdma e1000e
> JD> snd iTCO_wdt dibx000_common sg iTCO_vendor_support i7core_edac
> JD> soundcore i2c_tiny_usb i801_gpio edac_core snd_page_alloc dca pcspkr
> JD> button radeon ttm sd_mod drm_kms_helper drm i2c_algo_bit fan
> JD> processor ata_generic ata_piix ahci libahci libata sym53c8xx
> JD> scsi_transport_spi scsi_mod thermal thermal_sys [last unloaded:
> JD> gpio_i2cmux]
> JD> Pid: 29946, comm: rmmod Not tainted 2.6.39-rc3-git8 #77
> JD> Call Trace:
> JD>  [<ffffffff8105052a>] warn_slowpath_common+0x7a/0xb0
> JD>  [<ffffffff81050601>] warn_slowpath_fmt+0x41/0x50
> JD>  [<ffffffff8119f6a6>] ? remove_dir+0x36/0x40
> JD>  [<ffffffff812ee3c2>] device_release+0x82/0x90
> JD>  [<ffffffff81231e8d>] kobject_release+0x8d/0x1d0
> JD>  [<ffffffff81231e00>] ? kobject_del+0x80/0x80
> JD>  [<ffffffff81233817>] kref_put+0x37/0x70
> JD>  [<ffffffff81231d27>] kobject_put+0x27/0x60
> JD>  [<ffffffff812ee0f2>] put_device+0x12/0x20
> JD>  [<ffffffff812f42f2>] platform_device_put+0x12/0x20
> JD>  [<ffffffff812f44a9>] platform_device_unregister+0x19/0x20
> 
> So you tweaked the i801 driver to create and register a platform device
> for gpio-i2cmux which you then forcibly unregister in the i801 remove
> handler without providing a release() function on the platform device?

Exactly. Apparently I can't hide anything from you ;)

> That's afaik wrong as the platform_device might be in use (E.G. someone
> has the sysfs entry open or similar, and you need to use
> platform_device_alloc() which ensures that the device only gets freed
> when nobody is using it anymore.

You are totally right of course, I did this and the warning
disappeared. However I suspect that my first attempt was incomplete,
because gpio_i2cmux_platform_data.values and .gpio point to a static
array in i2c-i801.c and to a dynamically allocated array which is part
of the i2c-i801 device driver data structure, respectively. If the
gpio-i2cmux platform device is supposed to survive the removal of the
i2c-i801 driver, I guess that gpio_i2cmux_platform_data.values
and .gpio would end up pointing to already freed memory, which is not
good.

I defined a larger structure including the arrays in question to work
around this problem, but even that wasn't enough, because
platform_device_add_data() makes a raw copy of the whole structure
without translating the pointers, so I had to fix it up manually (took
me hours to figure it out, sigh.)

I end up with the following piece of code:

/*
 * We use a custom structure to add extra data to struct
 * gpio_i2cmux_platform_data. This is required so that the extra data
 * is available until the platform device gets released. The code assumes
 * that the struct gpio_i2cmux_platform_data is the first member of struct
 * i801_mux_gpio_data, i.e. both have the same address in memory.
 */
struct i801_mux_gpio_data {
	struct gpio_i2cmux_platform_data pfd;
	unsigned gpios[2];
	unsigned values[3];
};

static int match_gpio_chip_by_label(struct gpio_chip *chip, void *data)
{
	return !strcmp(data, chip->label);
}

/* Setup multiplexing if needed */
static int __devinit i801_add_mux(struct device *dev, struct i801_priv *priv)
{
	const struct dmi_system_id* id;
	struct gpio_chip *gpio;
	struct i801_mux_gpio_data gpio_data, *gpio_data_copy;
	int err;

	id = dmi_first_match(mux_dmi_table);
	if (!id)
		return 0;

	if (!strcmp(id->ident, "Z8NA-D6")) {
		/* Find GPIO pins */
		request_module("i801_gpio");
		gpio = gpiochip_find("i801_gpio", match_gpio_chip_by_label);
		if (gpio) {
			dev_err(dev, "Intel 82801 GPIO %sfound, "
				"SMBus multiplexing %sabled\n", "", "en");
		} else {
			dev_err(dev, "Intel 82801 GPIO %sfound, "
				"SMBus multiplexing %sabled\n", "not ", "dis");
			return -ENODEV;
		}
		dev_dbg(dev, "gpio->base = %u\n", gpio->base);
		dev_dbg(dev, "gpio_data at %p, gpio_data.pfd at %p\n",
			&gpio_data, &gpio_data.pfd);

		memset(&gpio_data, 0, sizeof(struct i801_mux_gpio_data));
		gpio_data.gpios[0] = gpio->base + 52;
		gpio_data.gpios[1] = gpio->base + 53;
		gpio_data.values[0] = 0x02;
		gpio_data.values[1] = 0x03;
		gpio_data.values[2] = 0x01;
		gpio_data.pfd.parent = priv->adapter.nr;
		gpio_data.pfd.values = &gpio_data.values[0];
		gpio_data.pfd.n_values = 3;
		gpio_data.pfd.gpios = &gpio_data.gpios[0];
		gpio_data.pfd.n_gpios = 2;
		gpio_data.pfd.idle = GPIO_I2CMUX_NO_IDLE;

		priv->mux_pdev = platform_device_alloc("gpio-i2cmux", -1);
		if (!priv->mux_pdev) {
			err = -ENOMEM;
			return err;
		}
		err = platform_device_add_data(priv->mux_pdev, &gpio_data,
				sizeof(struct i801_mux_gpio_data));
		if (err) {
			dev_err(dev,
				"Failed to add gpio-i2cmux platform data\n");
			platform_device_put(priv->mux_pdev);
			return err;
		}

		/*
		 * platform_device_add_data() made a copy of the data
		 * structure, but it can't deal with the pointers to
		 * embedded arrays. The pointers of the copy will point
		 * to the arrays of the original structure, which is no
		 * good. So we have to fix the pointers up.
		 */
		gpio_data_copy = priv->mux_pdev->dev.platform_data;
		gpio_data_copy->pfd.values = &gpio_data_copy->values[0];
		gpio_data_copy->pfd.gpios = &gpio_data_copy->gpios[0];

		err = platform_device_add(priv->mux_pdev);
		if (err) {
			dev_err(dev,
				"Failed to instantiate gpio-i2cmux device\n");
			platform_device_put(priv->mux_pdev);
			return err;
		}
	}

	return 0;
}

This seems to work (needs some more testing to confirm) but I wouldn't
call it elegant. In fact I would call it damn ugly. The time it took me
to get it right says a lot, and as far as I can tell, anybody willing
to instantiate a gpio-i2cmux platform device other than from arch setup
code will be bound to go through the same pain.

I start wondering if it really was such a good idea to define
gpio_i2cmux_platform_data.values and .gpio as pointers, rather than
plain embedded arrays. Sure, this gives us flexibility by not setting
arbitrary limits for the number of GPIOs and I2C channels. But do we
really expect devices with dozens of GPIOs and hundreds of I2C
channels? I have 2 GPIOs and 3 channels in my case, and the other case
I'll have to handle next is 1 GPIO and 2 channels. How many of each do
you have?

I think we could define max GPIO and channel counts (possibly through
Kconfig values if we can't agree on a default.) If we limit ourselves
to 8 GPIOs max then we can even use u8 to store the channel values, so
the resulting structure shouldn't be too large. For example 4 GPIOs max
and 16 channels max would take 8 * 4 + 16 = 48 bytes on 64-bit
architectures (4 * 4 + 16 = 32 bytes on 32-bit architectures) compared
to 8 * 2 = 16 bytes on 64-bit architectures (4 * 2 = 8 bytes on 32-bit
architectures) today. A growth of 32 bytes (resp. 24 bytes) for a
structure used only a couple times on a given system doesn't seem to be
a problem, does it?

So I think it all boils down to answering the question: are there
GPIO-based I2C multiplexers with more than 16 (or even 8) output
channels? What do you think?

Thanks,
-- 
Jean Delvare
