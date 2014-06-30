From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V3 5/5] I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI
 config
Date: Mon, 30 Jun 2014 09:32:39 +0800
Message-ID: <53B0BE37.7010103@intel.com>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com> <1400590764-11108-6-git-send-email-tianyu.lan@intel.com> <20140627110341.GD2641@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140627110341.GD2641@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8827=E6=97=A5 19:03, Wolfram Sang wrote:
> On Tue, May 20, 2014 at 08:59:24PM +0800, Lan Tianyu wrote:
>> Clean up ACPI related code in the i2c core and add CONFIG_I2C_ACPI
>> to enable I2C ACPI code.
>>
>> Current there is a race between removing I2C ACPI operation region
>> and ACPI AML code accessing. So make i2c core built-in if CONFIG_I2C=
_ACPI
>> is set.
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> Applied to for-next, thanks!
>=20

Great. Thanks :)


--=20
Best regards
Tianyu Lan
