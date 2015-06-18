From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 18 Jun 2015 11:09:47 +0200
Message-ID: <55828ADB.3080604@nokia.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <558288B0.1020706-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 18/06/15 11:00, ext Sekhar Nori wrote:
>> +	if (davinci_i2c_read_reg(dev, DAVINCI_I2C_ICPID2_REG) == 0x2206) {
>> > +		dev_dbg(dev->dev, "Keystone SoC detected\n");
>> > +		d = 6;
>> > +	}
> I think its better to use a different compatible string for i2c on
> keystone devices rather than using a fixed hardcoded IP version.

Yeah, this should have been done from the beginning, when the driver has been
re-used for Keystone, but this time is already missed, so I don't want
to introduce huge incompatibility with the existing device-trees.

And from the other PoV, device-trees are for something one cannot probe. We
can probe for Keystone revisions and can free the end-user from this headache
completely.

-- 
Best regards,
Alexander Sverdlin.
