From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v4
Date: Thu, 21 May 2009 00:20:13 +0200
Message-ID: <20090520222012.GB4541@sortiz.org>
References: <63386a3d0905200217i56accf6fw4ef2f8ed1793e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0905200217i56accf6fw4ef2f8ed1793e44-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Wed, May 20, 2009 at 11:17:18AM +0200, Linus Walleij wrote:
> This adds a core driver for the AB3100 mixed-signal circuit
> found in the ST-Ericsson U300 series platforms. This driver
> is a singleton proxy for all accesses to the AB3100
> sub-drivers which will be merged on top of this one, RTC,
> regulators, battery and system power control, vibrator,
> LEDs, and an ALSA codec.
This one looks much better, I still have some comments though:


> +
> +/* A local all-containing singleton */
> +static struct ab3100 *ab3100_local;
I dont really like that, but if you insist on having a unique ab3100 instance
for your driver (instead of allocating one with every probe call and passing
it as an i2c client data pointer), I could still ACK it. However:

> +static int ab3100_set_test_register(u8 reg, u8 regval)
> +{
> +	u8 regandval[2] = {reg, regval};
> +	int err;
> +
> +	err = mutex_lock_interruptible(&ab3100_local->access_mutex);
...that I wouldnt accept.
ab3100_set_test_register should be generic enough and have an ab3100 pointer
as its first parameter. It's called from ab3100_setup(), to which you can
passe the newly allocated ab3100.
There are several routines in your driver that rely on the existence of your
ab3100_local pointer. Let's go through them:

> +/* Interrupt handling worker */
> +static void ab3100_work(struct work_struct *work)
> +{
> +	u8 event_regs[3];
> +	u32 fatevent;
> +	int err;
struct ab3100 *ab3100 = container_of(work, struct ab3100, work);

and you dont have to reference your ab3100_local pointer anymore.


> +static irqreturn_t ab3100_irq_handler(int irq, void *data)
> +{
struct ab3100 *ab3100 = (struct ab3100 *)data;

you're even passing the ab3100 pointer to request_irq, so it's all set
already.


> + */
> +static int ab3100_registers_print(struct seq_file *s, void *p)
> +{
> +	u8 value;
> +	u8 reg;
> +
> +	seq_printf(s, "AB3100 registers:\n");
> +
> +	for (reg = 0; reg < 0xff; reg++) {
> +		ab3100_get_register(ab3100_local, reg, &value);
You could pass the probe() time allocated pointer to your debugfs_create_*()
calls, and then fetch it back here.
Same applies to all your debugfs code below.

> +static void ab3100_setup_debugfs(void)
> +{
This one needs to take a struct ab3100 * as an input.

> +static int __init ab3100_setup(void)
> +{
Ditto.

> +static int __init ab3100_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int err;
> +	int i;
> +
> +	ab3100_local = kzalloc(sizeof(struct ab3100), GFP_KERNEL);
> +	if (!ab3100_local) {
> +		dev_err(&client->dev, "could not allocate AB3100 device\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Initialize data structure */
> +	mutex_init(&ab3100_local->access_mutex);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&ab3100_local->event_subscribers);

i2c_set_clientdata(client, ab3100); and you can get rid of your static
ab3100_local declaration.

> +	ab3100_local->i2c_client = client;
> +	ab3100_local->dev = &ab3100_local->i2c_client->dev;
> +
> +	/* Read chip ID register */
> +	err = ab3100_get_register(ab3100_local, AB3100_CID,
> +				  &ab3100_local->chip_id);
> +	if (err) {
> +		dev_err(&client->dev,
> +			"could not communicate with the AB3100 analog "
> +			"baseband chip\n");
> +		goto exit_no_detect;
> +	}

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
