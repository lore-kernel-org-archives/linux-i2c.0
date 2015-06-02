From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/12] i2c: pxa: Add bus reset functionality
Date: Tue, 02 Jun 2015 23:10:32 +0530
Message-ID: <556DEA90.3010001@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org> <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org> <20150602173341.GA1494@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150602173341.GA1494@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Tuesday 02 June 2015 11:03 PM, Wolfram Sang wrote:
>
>> Since there is some problematic i2c slave devices on some
>> platforms such as dkb (sometimes), it will drop down sda
>> and make i2c bus hang, at that time, it need to config
>> scl/sda into gpio to simulate "stop" sequence to recover
>> i2c bus, so add this interface.
>
> Please note that the i2c core has a bus recovery infrastructure.
> Search i2c.h for struct i2c_bus_recovery_info.
>


Yeah,
I assume you are referring to "i2c_generic_gpio_recovery", right?

Rob had suggested this, and will be using it in my next version.

Thanks,
Vaibhav
