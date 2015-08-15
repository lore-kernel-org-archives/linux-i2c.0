From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
Date: Sat, 15 Aug 2015 13:56:42 +0100
Message-ID: <55CF370A.2020006@kernel.org>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-3-git-send-email-irina.tirdea@intel.com>
 <20150814182404.GC1822@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150814182404.GC1822@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 14/08/15 19:24, Wolfram Sang wrote:
> On Wed, Aug 12, 2015 at 05:31:34PM +0300, Irina Tirdea wrote:
>> For i2c busses that support only SMBUS extensions, the eeprom at24
>> driver reads data from the device using the SMBus block, word or byte
>> read protocols depending on availability.
>>
>> Replace the block read emulation from the driver with the
>> i2c_smbus_read_i2c_block_data_or_emulated call from i2c core.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Applied to for-next, thanks!
Cool.  These will presumably make it in during the coming
merge window.  I'll pick up the IIO ones next cycle
(IIO merge is probably now closed anyway as Linus is talking about
merge window opening next week I think).

Good work Irina,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
