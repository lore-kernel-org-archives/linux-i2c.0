From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: Ignore return value of i2c_del_adapter()
Date: Sat, 30 Mar 2013 08:55:39 +0100
Message-ID: <20130330085539.442321fa@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
	<1362853009-20789-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-4-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lars-Peter,

On Sat,  9 Mar 2013 19:16:46 +0100, Lars-Peter Clausen wrote:
> i2c_del_adapter() always returns 0.

I beg you pardon? i2c_del_adapter() starts with:

int i2c_del_adapter(struct i2c_adapter *adap)
{
	int res = 0;
	struct i2c_adapter *found;
	struct i2c_client *client, *next;

	/* First make sure that this adapter was ever added */
	mutex_lock(&core_lock);
	found = idr_find(&i2c_adapter_idr, adap->nr);
	mutex_unlock(&core_lock);
	if (found != adap) {
		pr_debug("i2c-core: attempting to delete unregistered "
			 "adapter [%s]\n", adap->name);
		return -EINVAL;
	}

	/* Tell drivers about this removal */
	mutex_lock(&core_lock);
	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
			       __process_removed_adapter);
	mutex_unlock(&core_lock);
	if (res)
		return res;
(...)

So, no, it doesn't "always return 0".

Thus nack from me.

-- 
Jean Delvare
