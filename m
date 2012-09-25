From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
Date: Tue, 25 Sep 2012 16:02:38 +0200
Message-ID: <5061B97E.2090005@free-electrons.com>
References: <1348474926-12763-1-git-send-email-maxime.ripard@free-electrons.com> <1348480425-13848-1-git-send-email-maxime.ripard@free-electrons.com> <1348480425-13848-3-git-send-email-maxime.ripard@free-electrons.com> <5060497D.9090104@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5060497D.9090104-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

Le 24/09/2012 13:52, Sergei Shtylyov a =E9crit :
> On 24-09-2012 13:53, Maxime Ripard wrote:
>=20
>> This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA955=
5
>> GPIO expander eventually.
>=20
>> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/imx28-cfa10049.dts |   33
>> +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>=20
>> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts
>> b/arch/arm/boot/dts/imx28-cfa10049.dts
>> index a9288fb..9a55632 100644
>> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
>> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
>> @@ -76,6 +76,39 @@
>>                   status =3D "okay";
>>               };
>>
>> +            i2cmux {
>> +                compatible =3D "i2c-mux-gpio";
>> +                #address-cells =3D <1>;
>> +                #size-cells =3D <0>;
>> +                mux-gpios =3D <&gpio1 22 0 &gpio1 23 0>;
>> +                i2c-parent =3D <&i2c1>;
>> +
>> +                i2c@0 {
>> +                    reg =3D <0>;
>> +                    #address-cells =3D <1>;
>> +                    #size-cells =3D <0>;
>=20
>    If you don't have any subnodes the above to props have no sense.

I will use them with subnodes eventually, with the 3 ADCs and the GPIO
expander. So these nodes won't be left empty.

On another hand, I can add these props when I'll add the devices, I hav=
e
no strong opinion here.

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
