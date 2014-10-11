From: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] i2c: MIPS: adds ralink I2C driver
Date: Sat, 11 Oct 2014 09:14:19 +0200
Message-ID: <5438D8CB.5080808@openwrt.org>
References: <1412970186-16030-1-git-send-email-blogic@openwrt.org> <20141011042423.GA1267@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141011042423.GA1267@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On 11/10/2014 06:24, Wolfram Sang wrote:
> Hi John,
>
>> +#define REG_CONFIG_REG		0x00
>> +#define REG_CLKDIV_REG		0x04
>> +#define REG_DEVADDR_REG		0x08
>> +#define REG_ADDR_REG		0x0C
>> +#define REG_DATAOUT_REG		0x10
>> +#define REG_DATAIN_REG		0x14
>> +#define REG_STATUS_REG		0x18
>> +#define REG_STARTXFR_REG	0x1C
>> +#define REG_BYTECNT_REG		0x20
> The register set looks like the one from i2c-xlr.c, only that they are
> 32 bit apart instead of 8. Can you check if you can reuse that driver?
>
> Thanks,
>
>    Wolfram
>
Hi Wolfram,

will do, thanks for the pointer

    John
