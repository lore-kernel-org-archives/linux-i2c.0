From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
Date: Wed, 13 Apr 2011 11:22:05 -0400
Message-ID: <BANLkTi=j=Dp015ZsU44DH3p1s_XdxvAX8Q@mail.gmail.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
	<f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bastian Ruppert <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>, "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sekhar,

On Wed, Apr 13, 2011 at 11:10 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> Hi Ben,
>
> On Wed, Apr 06, 2011 at 03:08:09, Ben Gardiner wrote:
>> Both the da850 and da830 have an I2C controller which has the ICPFUN=
C
>> registers. Indicate this for all da830 and da850 boards by setting t=
he
>> has_pfunc flag true in the da8xx utility setup routine for registeri=
ng the
>> I2C controller
>>
>> Signed-off-by: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
>> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>
>> ---
>> =A0arch/arm/mach-davinci/devices-da8xx.c | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-d=
avinci/devices-da8xx.c
>> index beda8a4..da01558 100644
>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> @@ -324,6 +324,12 @@ int __init da8xx_register_i2c(int instance,
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Both the DA850 and DA830 have an I2C controller which=
 has the
>> + =A0 =A0 =A0* ICPFUNC et. al. registers
>> + =A0 =A0 =A0*/
>> + =A0 =A0 pdata->has_pfunc =3D 1;
>
> The I2C driver implements a default platform data
> so it should actually be legal for a DA8x board to
> pass NULL platform data. In that case this line
> will crash.

Good catch, thanks.

> [...] You should either check for pdata to
> be NULL or just let each board choose whether it
> needs recovery (I think the better option).

I understand "check for pdata to be NULL."  If you think it is the
better option I'd be happy to implement it but I don't understand how
to implement "let each board choose whether it needs recovery."

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
