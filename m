From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] adv7604: Add support for i2c_new_secondary_device
Date: Thu, 23 Oct 2014 08:02:16 +0200
Message-ID: <CAL8zT=hD5J_pmkdV67Quoq3gzbZramRO4Kzav0OUYOEE_wQ4xw@mail.gmail.com>
References: <1413991848-28495-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <1413991848-28495-2-git-send-email-jean-michel.hautbois@vodalys.com> <3127348.3KALimKvms@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3127348.3KALimKvms@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

Thank you for reviewing,

2014-10-23 1:44 GMT+02:00 Laurent Pinchart <laurent.pinchart@ideasonboa=
rd.com>:
> Hi Jean-Michel,
>
> Thank you for the patch.
>
> On Wednesday 22 October 2014 17:30:48 Jean-Michel Hautbois wrote:
>> The ADV7604 has thirteen 256-byte maps that can be accessed via the =
main
>> I=C2=B2C ports. Each map has it own I=C2=B2C address and acts
>> as a standard slave device on the I=C2=B2C bus.
>>
>> If nothing is defined, it uses default addresses.
>> The main purpose is using two adv76xx on the same i2c bus.
>>
>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDaIwRZHo2/mJg@public.gmane.org=
m>
>> ---
>>  .../devicetree/bindings/media/i2c/adv7604.txt      | 16 +++++-
>>  drivers/media/i2c/adv7604.c                        | 59 +++++++++++=
+-------
>>  2 files changed, 53 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt index
>> 5c8b3e6..8486b5c 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>> @@ -12,7 +12,10 @@ Required Properties:
>>      - "adi,adv7611" for the ADV7611
>>      - "adi,adv7604" for the ADV7604
>
> Given that I'll have comment on the independent patch that adds suppo=
rt for
> the adv7604, you should rebase this series to remote that dependency =
if you
> want to get it merged now, otherwise it will get delayed.

Oh, you are right, of course, I forgot rebasing (as well as numbering
the patch as v2)...

>>
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
>> @@ -33,6 +36,12 @@ The digital output port node must contain at leas=
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
>
> If you rebase the series in order to avoid depending on the adv7604 D=
T support
> patch this line should be moved to "adv7604: Add DT parsing support".
>
>> +ADV7611 : "main", "cec", "infoframe", "afe", "rep", "edid", "hdmi",=
 "cp"
>>
>>  Optional Endpoint Properties:
>>
>> @@ -51,7 +60,10 @@ Example:
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
>> index 421035f..e4e30a2 100644
>> --- a/drivers/media/i2c/adv7604.c
>> +++ b/drivers/media/i2c/adv7604.c
>> @@ -326,6 +326,27 @@ static const struct adv7604_video_standards
>> adv7604_prim_mode_hdmi_gr[] =3D { { },
>>  };
>>
>> +struct adv7604_register {
>> +     const char *name;
>> +     u8 default_addr;
>> +};
>> +
>> +static const struct adv7604_register adv7604_secondary_names[] =3D =
{
>> +     [ADV7604_PAGE_IO] =3D { "main", 0x4c },
>> +     [ADV7604_PAGE_AVLINK] =3D { "avlink", 0x42 },
>> +     [ADV7604_PAGE_CEC] =3D { "cec", 0x40 },
>> +     [ADV7604_PAGE_INFOFRAME] =3D { "infoframe", 0x3e },
>> +     [ADV7604_PAGE_ESDP] =3D { "esdp", 0x38 },
>> +     [ADV7604_PAGE_DPP] =3D { "dpp", 0x3c },
>> +     [ADV7604_PAGE_AFE] =3D { "afe", 0x26 },
>> +     [ADV7604_PAGE_REP] =3D { "rep", 0x32 },
>> +     [ADV7604_PAGE_EDID] =3D { "edid", 0x36 },
>> +     [ADV7604_PAGE_HDMI] =3D { "hdmi", 0x34 },
>> +     [ADV7604_PAGE_TEST] =3D { "test", 0x30 },
>> +     [ADV7604_PAGE_CP] =3D { "cp", 0x22 },
>> +     [ADV7604_PAGE_VDP] =3D { "vdp", 0x24 },
>> +};
>> +
>>  /* ----------------------------------------------------------------=
-------
>> */
>>
>>  static inline struct adv7604_state *to_state(struct v4l2_subdev *sd=
)
>> @@ -2528,13 +2549,26 @@ static void adv7604_unregister_clients(struc=
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
> The variable isn't used.

Removed. Again, didn't check sufficiently my compiler warnings...

>> +     struct i2c_client *new_client;
>> +
>> +     if (pdata && pdata->i2c_addresses[i])
>> +             new_client =3D i2c_new_dummy(client->adapter,
>> +                                     pdata->i2c_addresses[i]);
>> +     else
>> +             new_client =3D i2c_new_secondary_device(client,
>> +                     adv7604_secondary_names[i].name,
>> +                     adv7604_secondary_names[i].default_addr);
>> +
>> +     if (new_client)
>> +             io_write(sd, io_reg, new_client->addr << 1);
>>
>> -     if (addr)
>> -             io_write(sd, io_reg, addr << 1);
>> -     return i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1=
);
>> +     return new_client;
>>  }
>>
>>  static const struct adv7604_reg_seq adv7604_recommended_settings_af=
e[] =3D {
>> @@ -2718,20 +2752,6 @@ static int adv7604_parse_dt(struct adv7604_st=
ate
>> *state) /* Disable the interrupt for now as no DT-based board uses i=
t. */
>> state->pdata.int1_config =3D ADV7604_INT1_CONFIG_DISABLED;
>>
>> -     /* Use the default I2C addresses. */
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_AVLINK] =3D 0x42;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_CEC] =3D 0x40;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_INFOFRAME] =3D 0x3e;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_ESDP] =3D 0x38;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_DPP] =3D 0x3c;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_AFE] =3D 0x26;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_REP] =3D 0x32;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_EDID] =3D 0x36;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_HDMI] =3D 0x34;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_TEST] =3D 0x30;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_CP] =3D 0x22;
>> -     state->pdata.i2c_addresses[ADV7604_PAGE_VDP] =3D 0x24;
>> -
>>       /* Hardcode the remaining platform data fields. */
>>       state->pdata.disable_pwrdnb =3D 0;
>>       state->pdata.disable_cable_det_rst =3D 0;
>> @@ -2892,8 +2912,7 @@ static int adv7604_probe(struct i2c_client *cl=
ient,
>>                       continue;
>>
>>               state->i2c_clients[i] =3D
>> -                     adv7604_dummy_client(sd, state->pdata.i2c_addr=
esses[i],
>> -                                          0xf2 + i);
>> +                     adv7604_dummy_client(sd, i);
>>               if (state->i2c_clients[i] =3D=3D NULL) {
>>                       err =3D -ENOMEM;
>>                       v4l2_err(sd, "failed to create i2c client %u\n=
", i);
>
> --
> Regards,
>
> Laurent Pinchart
>

Thanks,
JM
