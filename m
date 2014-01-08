From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 1/3] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Wed, 08 Jan 2014 15:16:37 +0100
Message-ID: <52CD5DC5.2030305@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com> <1389112504-9931-2-git-send-email-gregory.clement@free-electrons.com> <201401081355.38293.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <201401081355.38293.arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, stable@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On 08/01/2014 13:55, Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Gregory CLEMENT wrote:
>> diff --git a/include/linux/mvebu-soc-id.h b/include/linux/mvebu-soc-id.h
>> new file mode 100644
>> index 000000000000..31654252fe35
>> --- /dev/null
>> +++ b/include/linux/mvebu-soc-id.h
>> +#ifdef CONFIG_ARCH_MVEBU
>> +int mvebu_get_soc_id(u32 *dev, u32 *rev);
>> +#else
>> +static inline int mvebu_get_soc_id(u32 *dev, u32 *rev)
>> +{
>> +	return -1;
>> +}
>> +#endif
>> +
>> +#endif /* __LINUX_MVEBU_SOC_ID_H */
> 
> With the quirk handling in patch 3, I think we should remove the public interface
> and EXPORT_SYMBOL(), as well as move this header file into mach-mvebu.
> 
> That said, we may want to add support for the soc_bus later on (not as part of the
> stable bug fix) to make it possible to query the soc version from user space through
> the standard sysfs files.

We could do it later indeed. For having a more acceptable patch for stable I will move
this header file into mach-mvebu.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
