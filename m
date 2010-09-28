From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: AT88SC
Date: Tue, 28 Sep 2010 09:05:08 +0200
Message-ID: <20100928090508.79de9d01@endymion.delvare>
References: <4CA0A45F.7090104@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CA0A45F.7090104-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfgang,

On Mon, 27 Sep 2010 16:04:15 +0200, Wolfgang Grandegger wrote:
> is there any known Linux support for Atmel's CryptoMemory chips AT88SC,
> e.g. [1]?

Not that I know of.

> It seems not to be a real I2C device as it does not support
> I2C addressing. Could it be handled with the I2C interface anyway?

After a quick look at the datasheet, I don't see any problem handing
this chip with the I2C interface. Its addressing is indeed uncommon, so
you won't be able to use the SMBus command set, but raw I2C transfers
should work just fine.

-- 
Jean Delvare
