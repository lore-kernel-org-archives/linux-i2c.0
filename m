From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] adv7604: Use DT parsing in dummy creation
Date: Mon, 1 Sep 2014 12:08:31 +0200
Message-ID: <CAL8zT=jjEsTt4NPs_quiFB4hosOc7r=OiPC5RyvTNOaOW+uG8g@mail.gmail.com>
References: <1409325303-15906-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <1409325303-15906-2-git-send-email-jean-michel.hautbois@vodalys.com> <2204455.3fKSNVsp04@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2204455.3fKSNVsp04@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2014-08-31 19:18 GMT+02:00 Laurent Pinchart <laurent.pinchart@ideasonbo=
ard.com>:
> Hi Jean-Michel,
>
> Thank you for the patch.
>
> On Friday 29 August 2014 17:15:03 Jean-Michel Hautbois wrote:
>> This patch uses DT in order to parse addresses for dummy devices of =
adv7604.
>> The ADV7604 has thirteen 256-byte maps that can be accessed via the =
main
>> I=C2=B2C ports. Each map has it own I=C2=B2C address and acts
>> as a standard slave device on the I=C2=B2C bus.
>>
>> If nothing is defined, it uses default addresses.
>> The main prupose is using two adv76xx on the same i2c bus.
>>
>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDaIwRZHo2/mJg@public.gmane.org=
m>
>> ---
>>  .../devicetree/bindings/media/i2c/adv7604.txt      | 17 +++++-
>>  drivers/media/i2c/adv7604.c                        | 60 +++++++++++=
+-------
>>  2 files changed, 55 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt index
>> c27cede..8486b5c 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> @@ -10,8 +10,12 @@ Required Properties:
>>
>>    - compatible: Must contain one of the following
>>      - "adi,adv7611" for the ADV7611
>> +    - "adi,adv7604" for the ADV7604
>
> Addition of ADV7604 support is unrelated to the subject and needs to =
be split
> into a separate patch.

OK, I will do that.

>> -  - reg: I2C slave address
>> +  - reg: I2C slave addresses
>> +    The ADV7604 has thirteen 256-byte maps that can be accessed via=
 the
>> main
>> +    I=C2=B2C ports. Each map has it own I=C2=B2C address and acts
>> +    as a standard slave device on the I=C2=B2C bus.
>>
>>    - hpd-gpios: References to the GPIOs that control the HDMI hot-pl=
ug
>>      detection pins, one per HDMI input. The active flag indicates t=
he GPIO
>> @@ -32,6 +36,12 @@ The digital output port node must contain at leas=
t one
>> endpoint. Optional Properties:
>>
>>    - reset-gpios: Reference to the GPIO connected to the device's re=
set pin.
>> +  - reg-names : Names of maps with programmable addresses.
>> +             It can contain any map needing another address than de=
fault one.
>> +             Possible maps names are :
>> +ADV7604 : "main", "avlink", "cec", "infoframe", "esdp", "dpp", "afe=
",
>> "rep",
>> +             "edid", "hdmi", "test", "cp", "vdp"
>> +ADV7611 : "main", "cec", "infoframe", "afe", "rep", "edid", "hdmi",=
 "cp"
>>
>>  Optional Endpoint Properties:
>>
>> @@ -50,7 +60,10 @@ Example:
>>
>>       hdmi_receiver@4c {
>>               compatible =3D "adi,adv7611";
>> -             reg =3D <0x4c>;
>> +             /* edid page will be accessible @ 0x66 on i2c bus */
>> +             /* other maps keep their default addresses */
>> +             reg =3D <0x4c 0x66>;
>> +             reg-names =3D "main", "edid";
>>
>>               reset-gpios =3D <&ioexp 0 GPIO_ACTIVE_LOW>;
>>               hpd-gpios =3D <&ioexp 2 GPIO_ACTIVE_HIGH>;
>> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604=
=2Ec
>> index d4fa213..56037dd 100644
>> --- a/drivers/media/i2c/adv7604.c
>> +++ b/drivers/media/i2c/adv7604.c
>> @@ -326,6 +326,22 @@ static const struct adv7604_video_standards
>> adv7604_prim_mode_hdmi_gr[] =3D { { },
>>  };
>>
>> +static const char const *adv7604_secondary_names[] =3D {
>> +     "main", /* ADV7604_PAGE_IO */
>> +     "avlink", /* ADV7604_PAGE_AVLINK */
>> +     "cec", /* ADV7604_PAGE_CEC */
>> +     "infoframe", /* ADV7604_PAGE_INFOFRAME */
>> +     "esdp", /* ADV7604_PAGE_ESDP */
>> +     "dpp", /* ADV7604_PAGE_DPP */
>> +     "afe", /* ADV7604_PAGE_AFE */
>> +     "rep", /* ADV7604_PAGE_REP */
>> +     "edid", /* ADV7604_PAGE_EDID */
>> +     "hdmi", /* ADV7604_PAGE_HDMI */
>> +     "test", /* ADV7604_PAGE_TEST */
>> +     "cp", /* ADV7604_PAGE_CP */
>> +     "vdp" /* ADV7604_PAGE_VDP */
>> +};
>> +
>>  /* ----------------------------------------------------------------=
-------
>> */
>>
>>  static inline struct adv7604_state *to_state(struct v4l2_subdev *sd=
)
>> @@ -2528,13 +2544,31 @@ static void adv7604_unregister_clients(struc=
t
>> adv7604_state *state) }
>>
>>  static struct i2c_client *adv7604_dummy_client(struct v4l2_subdev *=
sd,
>> -                                                     u8 addr, u8 io=
_reg)
>> +                                             unsigned int i)
>>  {
>>       struct i2c_client *client =3D v4l2_get_subdevdata(sd);
>> +     struct adv7604_platform_data *pdata =3D client->dev.platform_d=
ata;
>> +     unsigned int io_reg =3D 0xf2 + i;
>> +     unsigned int default_addr =3D io_read(sd, io_reg) >> 1;
>
> This modifies the behaviour of the driver. It previously used fixed d=
efault
> addresses in the DT case, and now defaults to whatever has been progr=
ammed in
> the chip. This might not be an issue in itself, but it should be docu=
mented in
> the commit message (and possibly split to a separate patch).

Then, let's decide if this is a problem or not :) ? I naively thought
that it would be good to have default address, if defined in platform
data, use this one instead, and if it is in DT, it should be the prior
address to use (priority on DT and not on platform data).
But this is probably ideal for me but not for others ?

Thanks,
JM
