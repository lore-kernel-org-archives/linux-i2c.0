From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: change the id to let the i2c device work
Date: Fri, 12 Oct 2012 10:05:21 +0200
Message-ID: <20121012100521.64cb9adb@endymion.delvare>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
	<20121012044042.GI11726@opensource.wolfsonmicro.com>
	<5077A33E.4080801@atmel.com>
	<20121012051419.GJ11726@opensource.wolfsonmicro.com>
	<5077AE8C.5040605@atmel.com>
	<20121012055301.GM11726@opensource.wolfsonmicro.com>
	<20121012091427.0d7b2bed@endymion.delvare>
	<5077CCF4.7070104@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5077CCF4.7070104-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 12 Oct 2012 15:55:32 +0800, Bo Shen wrote:
> vim I only see the i2c-gpio platform data structure as following:
> --<---------------------
> struct i2c_gpio_platform_data {
> 	unsigned int	sda_pin;
> 	unsigned int	scl_pin;
> 	int		udelay;
> 	int		timeout;
> 	unsigned int	sda_is_open_drain:1;
> 	unsigned int	scl_is_open_drain:1;
> 	unsigned int	scl_is_output_only:1;
> };
> -->---------------------

Ah sorry I misread Mark's request. i2c-gpio will turn the platform
device ID into bus number, it can indeed not be forced through platform
data. But I don't think any other i2c bus driver allows this either. I
don't quite see the problem with setting a platform device ID even if
there's only one instance of the platform device. I have many examples
of this on my machine:
Fixed MDIO bus.0
coretemp.0
vesafb.0

So please just set the platform device ID to 0 (or whatever i2c adapter
number you want) and your problem is solved. As you just proposed
initially, actually :)

-- 
Jean Delvare
