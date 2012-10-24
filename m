From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH 2/2] i2c: i2c-ocores: Add support for the GRLIB port of
 the controller and custom getreg and setreg functions
Date: Wed, 24 Oct 2012 11:05:10 +0200
Message-ID: <5087AF46.1070707@gaisler.com>
References: <1351004637-11049-1-git-send-email-andreas@gaisler.com> <1351004637-11049-3-git-send-email-andreas@gaisler.com> <87sj95lywu.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sj95lywu.fsf@macbook.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, software@gaisler.com
List-Id: linux-i2c@vger.kernel.org

On 10/23/2012 10:24 PM, Peter Korsgaard wrote:
>>>>>> "Andreas" == Andreas Larsson <andreas@gaisler.com> writes:
>   [...]
>   Andreas> +/* Read and write functions for the GRLIB port of the controller. Registers are
>   Andreas> + * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
>   Andreas> + * register. The subsequent registers has their offset decreased accordingly. */
>   Andreas> +static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
>   Andreas> +{
>   Andreas> +	u32 rd;
>   Andreas> +	int rreg = reg;
>   Andreas> +	if (reg != OCI2C_PRELOW)
>   Andreas> +		rreg--;
>   Andreas> +	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
>   Andreas> +	if (reg == OCI2C_PREHIGH)
>   Andreas> +		return (u8)rd >> 8;
>   Andreas> +	else
>   Andreas> +		return (u8)rd;
>   Andreas> +}
>   Andreas> +
>   Andreas> +static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
>   Andreas> +{
>   Andreas> +	u32 curr, wr;
>   Andreas> +	int rreg = reg;
>   Andreas> +	if (reg != OCI2C_PRELOW)
>   Andreas> +		rreg--;
>   Andreas> +	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
>   Andreas> +		curr = ioread32be(i2c->base + (rreg << i2c->reg_shift));
>   Andreas> +		if (reg == OCI2C_PRELOW)
>   Andreas> +			wr = (curr & 0xff00) | value;
>   Andreas> +		else
>   Andreas> +			wr = (((u32)value) << 8) | (curr & 0xff);
>   Andreas> +	} else {
>   Andreas> +		wr = value;
>   Andreas> +	}
>   Andreas> +	iowrite32be(wr, i2c->base + (rreg << i2c->reg_shift));
>
> Are all platforms using i2c-ocores guaranteed to provide ioread32be /
> iowrite32be or should we stick an #ifdef CONFIG_SPARC around it?

As far as I can see, after digging around, the only platforms that have 
ioread/write32, but not ioread/write32be are frv and mn10300. Do you 
know if those platforms are using i2c-ocores?

Cheers,
Andreas Larsson
