From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2] iio: light: Adding driver for ISL29018 ALS
Date: Tue, 05 Oct 2010 14:41:43 -0700
Message-ID: <1286314903.2156.54.camel@Joe-Laptop>
References: <1286313561-6456-1-git-send-email-rklein@nvidia.com>
	 <1286314517.2156.50.camel@Joe-Laptop>
	 <E88A1D35AF5437468E5B14C7C4BA61C702D2D2620A@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E88A1D35AF5437468E5B14C7C4BA61C702D2D2620A-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2010-10-05 at 14:36 -0700, Rhyland Klein wrote:
> > -----Original Message-----
> > From: Joe Perches [mailto:joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org]
> > > diff --git a/drivers/staging/iio/light/isl29018.c
> > b/drivers/staging/iio/light/isl29018.c
> > > +static int isl29018_chip_init(struct i2c_client *client)
> > > +{
> > > +	struct isl29018_chip *chip = i2c_get_clientdata(client);
> > > +	int status;
> > > +	int i;
> > > +	int new_adc_bit;
> > > +	unsigned int new_range;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(chip->reg_cache); i++)
> > > +		chip->reg_cache[i] = 0;
> > memset?
> I could use memset, except this is only 4 registers = 32 bytes,
> so I don't think that is really worth it do you?

Your choice.  I don't care really.  I didn't look to
see how many elements were in chip->reg_cache.

I just noted it as whenever I see a loop initialization
like that, I think memset not loop.

cheers, Joe
