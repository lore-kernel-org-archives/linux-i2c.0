From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: change the id to let the i2c device work
Date: Fri, 12 Oct 2012 15:55:32 +0800
Message-ID: <5077CCF4.7070104@atmel.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com> <20121012044042.GI11726@opensource.wolfsonmicro.com> <5077A33E.4080801@atmel.com> <20121012051419.GJ11726@opensource.wolfsonmicro.com> <5077AE8C.5040605@atmel.com> <20121012055301.GM11726@opensource.wolfsonmicro.com> <20121012091427.0d7b2bed@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121012091427.0d7b2bed-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean Delvare,

On 10/12/2012 15:14, Jean Delvare wrote:
> On Fri, 12 Oct 2012 14:53:02 +0900, Mark Brown wrote:
>> On Fri, Oct 12, 2012 at 01:45:48PM +0800, Bo Shen wrote:
>>> So, in this case, if the id = -1, i2c core will dynamically assign a
>>> bus id to this bus when running, the dynamically assigned bus id is
>>> unknown when writing the code. So, when we use
>>> i2c_register_board_info(int busnum, ...) to register device on
>>> busnum. we don't know which value to be use.
>>
>> The I2C bus number assigned to the controller should be independant of
>> the platform device ID used to register the device; a better fix if this
>> is an issue would be to update the i2c-gpio driver to allow a fixed bus
>> number to be specified in platform data.
>
> i2c-gpio does support this already.

vim I only see the i2c-gpio platform data structure as following:
--<---------------------
struct i2c_gpio_platform_data {
	unsigned int	sda_pin;
	unsigned int	scl_pin;
	int		udelay;
	int		timeout;
	unsigned int	sda_is_open_drain:1;
	unsigned int	scl_is_open_drain:1;
	unsigned int	scl_is_output_only:1;
};
-->---------------------

So, how to allow a fixed bus number to be specified in platform data?
