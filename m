From: BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Tue, 14 Oct 2008 15:15:10 +0200
Message-ID: <C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DA@PRI-MBX-101.dom1.vinci-energies.net>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<20081010133344.653431af@hyperion.delvare>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BE5A032@PRI-MBX-101.dom1.vinci-energies.net>
	<20081013173206.6b7a5e1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DAPRIMBX101dom1_"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081013173206.6b7a5e1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--_002_C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DAPRIMBX101dom1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
...
> Note: you need to include a comment describing what your patch does,
> as well as your Signed-off-by line. Here's a second review from me.
> After that it will be up to Alessandro and the RTC folks.
>

So I'm waiting for their comments.

> > --- a/drivers/rtc/rtc-ds1307.c        2008-09-08 19:40:20.000000000
> +0200
> > +++ b/drivers/rtc/rtc-ds1307.c        2008-10-10 16:30:59.000000000
> +0200
> > @@ -17,8 +17,6 @@
> >  #include <linux/rtc.h>
> >  #include <linux/bcd.h>
> >
> > -
> > -
>
> Unrelated white space change, please revert.

OK

> >  /* We can't determine type by probing, but if we expect pre-Linux
> code
> >   * to have set the chip up as a clock (turning on the oscillator and
> >   * setting the date and time), Linux can ignore the non-clock
> features.
> > @@ -38,7 +36,6 @@ enum ds_type {
> >       // rs5c372 too?  different address...
> >  };
> >
> > -
>
> Unrelated white space change, please revert.

OK

> >  /* RTC registers don't differ much, except for the century flag */
> >  #define DS1307_REG_SECS              0x00    /* 00-59 */
> >  #    define DS1307_BIT_CH            0x80
> > @@ -85,14 +82,11 @@ enum ds_type {
> >  #    define DS1337_BIT_A1I           0x01
> >  #define DS1339_REG_TRICKLE   0x10
> >
> > -
> > -
>
> Unrelated white space change, please revert.

OK

> >  struct ds1307 {
> >       u8                      reg_addr;
>
> reg_addr is unused after your changes, so you should remove it as well.

OK

> >       bool                    has_nvram;
> >       u8                      regs[8];
> >       enum ds_type            type;
> > -     struct i2c_msg          msg[2];
> >       struct i2c_client       *client;
> >       struct i2c_client       dev;
> >       struct rtc_device       *rtc;
> > @@ -138,12 +132,9 @@ static int ds1307_get_time(struct device
> >       int             tmp;
> >
> >       /* read the RTC date and time registers all at once */
> > -     ds1307->msg[1].flags =3D I2C_M_RD;
> > -     ds1307->msg[1].len =3D 7;
> > -
> > -     tmp =3D i2c_transfer(to_i2c_adapter(ds1307->client->dev.parent),
> > -                     ds1307->msg, 2);
> > -     if (tmp !=3D 2) {
> > +     tmp =3D i2c_smbus_read_i2c_block_data(ds1307->client,
> > +                     DS1307_REG_SECS, 7, ds1307->regs);
> > +     if (tmp !=3D 7) {
> >               dev_err(dev, "%s error %d\n", "read", tmp);
> >               return -EIO;
> >       }
> > @@ -181,8 +172,6 @@ static int ds1307_set_time(struct device  {
> >       struct ds1307   *ds1307 =3D dev_get_drvdata(dev);
> >       int             result;
> > -     int             tmp;
> > -     u8              *buf =3D ds1307->regs;
> >
> >       dev_dbg(dev, "%s secs=3D%d, mins=3D%d, "
> >               "hours=3D%d, mday=3D%d, mon=3D%d, year=3D%d, wday=3D%d\n"=
, @@
> > -190,44 +179,41 @@ static int ds1307_set_time(struct device
> >               t->tm_hour, t->tm_mday,
> >               t->tm_mon, t->tm_year, t->tm_wday);
> >
> > -     *buf++ =3D 0;             /* first register addr */
> > -     buf[DS1307_REG_SECS] =3D BIN2BCD(t->tm_sec);
> > -     buf[DS1307_REG_MIN] =3D BIN2BCD(t->tm_min);
> > -     buf[DS1307_REG_HOUR] =3D BIN2BCD(t->tm_hour);
> > -     buf[DS1307_REG_WDAY] =3D BIN2BCD(t->tm_wday + 1);
> > -     buf[DS1307_REG_MDAY] =3D BIN2BCD(t->tm_mday);
> > -     buf[DS1307_REG_MONTH] =3D BIN2BCD(t->tm_mon + 1);
> > +     ds1307->regs[DS1307_REG_SECS] =3D BIN2BCD(t->tm_sec);
> > +     ds1307->regs[DS1307_REG_MIN] =3D BIN2BCD(t->tm_min);
> > +     ds1307->regs[DS1307_REG_HOUR] =3D BIN2BCD(t->tm_hour);
> > +     ds1307->regs[DS1307_REG_WDAY] =3D BIN2BCD(t->tm_wday + 1);
> > +     ds1307->regs[DS1307_REG_MDAY] =3D BIN2BCD(t->tm_mday);
> > +     ds1307->regs[DS1307_REG_MONTH] =3D BIN2BCD(t->tm_mon + 1);
>
> This change makes the patch larger (and thus harder to review) with
> almost no benefit. Same for many changes below... Why don't you keep
> the buf pointer? Please keep in mind that your patch should do just
> one thing and do it well.

It was to avoid the usage of buf, but I can reverse it if you think it's cl=
earer

> >       /* assume 20YY not 19YY */
> > -     tmp =3D t->tm_year - 100;
> > -     buf[DS1307_REG_YEAR] =3D BIN2BCD(tmp);
> > +     ds1307->regs[DS1307_REG_YEAR] =3D BIN2BCD(t->tm_year - 100);
> >
> >       switch (ds1307->type) {
> >       case ds_1337:
> >       case ds_1339:
> > -             buf[DS1307_REG_MONTH] |=3D DS1337_BIT_CENTURY;
> > +             ds1307->regs[DS1307_REG_MONTH] |=3D DS1337_BIT_CENTURY;
> >               break;
> >       case ds_1340:
> > -             buf[DS1307_REG_HOUR] |=3D DS1340_BIT_CENTURY_EN
> > -                             | DS1340_BIT_CENTURY;
> > +             ds1307->regs[DS1307_REG_HOUR] |=3D DS1340_BIT_CENTURY_EN
> > +                                             | DS1340_BIT_CENTURY;
> >               break;
> >       default:
> >               break;
> >       }
> >
> > -     ds1307->msg[1].flags =3D 0;
> > -     ds1307->msg[1].len =3D 8;
> > -
> >       dev_dbg(dev, "%s: %02x %02x %02x %02x %02x %02x %02x\n",
> > -             "write", buf[0], buf[1], buf[2], buf[3],
> > -             buf[4], buf[5], buf[6]);
> > -
> > -     result =3D i2c_transfer(to_i2c_adapter(ds1307->client-
> >dev.parent),
> > -                     &ds1307->msg[1], 1);
> > -     if (result !=3D 1) {
> > -             dev_err(dev, "%s error %d\n", "write", tmp);
> > -             return -EIO;
> > +             "write", ds1307->regs[0], ds1307->regs[1],
> > +             ds1307->regs[2], ds1307->regs[3],
> > +             ds1307->regs[4], ds1307->regs[5], ds1307->regs[6]);
> > +
> > +     result =3D i2c_smbus_write_i2c_block_data(ds1307->client,
> > +                     0, 7, ds1307->regs);
> > +     if (result < 0) {
> > +             dev_err(dev, "%s error %d\n", "write", result);
> > +             return result;
> >       }
> > +
> >       return 0;
> >  }
> >
> > @@ -246,7 +232,6 @@ ds1307_nvram_read(struct kobject *kobj,  {
> >       struct i2c_client       *client;
> >       struct ds1307           *ds1307;
> > -     struct i2c_msg          msg[2];
> >       int                     result;
> >
> >       client =3D kobj_to_i2c_client(kobj); @@ -259,24 +244,13 @@
> > ds1307_nvram_read(struct kobject *kobj,
> >       if (unlikely(!count))
> >               return count;
> >
> > -     msg[0].addr =3D client->addr;
> > -     msg[0].flags =3D 0;
> > -     msg[0].len =3D 1;
> > -     msg[0].buf =3D buf;
> > -
> > -     buf[0] =3D 8 + off;
> > -
> > -     msg[1].addr =3D client->addr;
> > -     msg[1].flags =3D I2C_M_RD;
> > -     msg[1].len =3D count;
> > -     msg[1].buf =3D buf;
> > -
> > -     result =3D i2c_transfer(to_i2c_adapter(client->dev.parent), msg,
> 2);
> > -     if (result !=3D 2) {
> > -             dev_err(&client->dev, "%s error %d\n", "nvram read",
> result);
> > -             return -EIO;
> > +     result =3D i2c_smbus_read_i2c_block_data(client, 8 + off, count,
> buf);
> > +     if (result < 0) {
> > +             dev_err(&client->dev, "%s error %d\n", "read",
> > + result);
>
> Why did you change this error message for a less specific one?

I think it's better to use the error value returned from i2c_smbus_read_i2c=
_block_data than to hard-code an error value.

> > +             return result;
> >       }
> > -     return count;
> > +
> > +     return result;
> >  }
>
> Note that "return result" can be factored out.

OK

> >
> >  static ssize_t
> > @@ -284,8 +258,7 @@ ds1307_nvram_write(struct kobject *kobj,
> >               char *buf, loff_t off, size_t count)  {
> >       struct i2c_client       *client;
> > -     u8                      buffer[NVRAM_SIZE + 1];
> > -     int                     ret;
> > +     int                     result;
> >
> >       client =3D kobj_to_i2c_client(kobj);
> >
> > @@ -296,11 +269,12 @@ ds1307_nvram_write(struct kobject *kobj,
> >       if (unlikely(!count))
> >               return count;
> >
> > -     buffer[0] =3D 8 + off;
> > -     memcpy(buffer + 1, buf, count);
> > -
> > -     ret =3D i2c_master_send(client, buffer, count + 1);
> > -     return (ret < 0) ? ret : (ret - 1);
> > +     result =3D i2c_smbus_write_i2c_block_data(client, 8 + off, count,
> buf);
> > +     if (result < 0) {
> > +             dev_err(&client->dev, "%s error %d\n", "write",
> result);
>
> I'd use "nvram write" in the error message.

You're right, it's better.

New version is attached for tests and comments

--
S=E9bastien Barr=E9
Bureau d'=E9tude - D=E9veloppement
SDEL Contr=F4le Commande
D2A - Rue Nungesser et Coli
44860 Saint Aignan de Grand Lieu
FRANCE
T=E9l : +33(0)2 40 84 50 88
Fax : +33(0)2 40 84 51 10

--_002_C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DAPRIMBX101dom1_
Content-Type: application/octet-stream; name="patch-rtc-ds1307"
Content-Description: patch-rtc-ds1307
Content-Disposition: attachment; filename="patch-rtc-ds1307"; size=0;
	creation-date="Tue, 14 Oct 2008 13:13:05 GMT";
	modification-date="Tue, 14 Oct 2008 12:46:23 GMT"
Content-Transfer-Encoding: base64

VGhpcyBwYXRjaCBjaGFuZ2UgaTJjIGFjY2VzcyBmdW5jdGlvbnMgdG8gU01CdXMgYWNjZXNzIGZ1
bmN0aW9ucwppbiBvcmRlciB0byB1c2UgdGhlIGRzMTMwNyB3aXRoIFNNQnVzIGFkYXB0ZXIuCgpT
aWduZWQtb2ZmLWJ5OiBTZWJhc3RpZW4gQmFycmUgPHNiYXJyZUBzZGVsY2MuY29tPgoKLS0tIGEv
ZHJpdmVycy9ydGMvcnRjLWRzMTMwNy5jCTIwMDgtMDktMDggMTk6NDA6MjAuMDAwMDAwMDAwICsw
MjAwCisrKyBiL2RyaXZlcnMvcnRjL3J0Yy1kczEzMDcuYwkyMDA4LTEwLTE0IDE0OjIyOjEyLjAw
MDAwMDAwMCArMDIwMApAQCAtODgsMTEgKzg4LDkgQEAgZW51bSBkc190eXBlIHsKIAogCiBzdHJ1
Y3QgZHMxMzA3IHsKLQl1OAkJCXJlZ19hZGRyOwogCWJvb2wJCQloYXNfbnZyYW07CiAJdTgJCQly
ZWdzWzhdOwogCWVudW0gZHNfdHlwZQkJdHlwZTsKLQlzdHJ1Y3QgaTJjX21zZwkJbXNnWzJdOwog
CXN0cnVjdCBpMmNfY2xpZW50CSpjbGllbnQ7CiAJc3RydWN0IGkyY19jbGllbnQJZGV2OwogCXN0
cnVjdCBydGNfZGV2aWNlCSpydGM7CkBAIC0xMzgsMTIgKzEzNiw5IEBAIHN0YXRpYyBpbnQgZHMx
MzA3X2dldF90aW1lKHN0cnVjdCBkZXZpY2UKIAlpbnQJCXRtcDsKIAogCS8qIHJlYWQgdGhlIFJU
QyBkYXRlIGFuZCB0aW1lIHJlZ2lzdGVycyBhbGwgYXQgb25jZSAqLwotCWRzMTMwNy0+bXNnWzFd
LmZsYWdzID0gSTJDX01fUkQ7Ci0JZHMxMzA3LT5tc2dbMV0ubGVuID0gNzsKLQotCXRtcCA9IGky
Y190cmFuc2Zlcih0b19pMmNfYWRhcHRlcihkczEzMDctPmNsaWVudC0+ZGV2LnBhcmVudCksCi0J
CQlkczEzMDctPm1zZywgMik7Ci0JaWYgKHRtcCAhPSAyKSB7CisJdG1wID0gaTJjX3NtYnVzX3Jl
YWRfaTJjX2Jsb2NrX2RhdGEoZHMxMzA3LT5jbGllbnQsCisJCQlEUzEzMDdfUkVHX1NFQ1MsIDcs
IGRzMTMwNy0+cmVncyk7CisJaWYgKHRtcCAhPSA3KSB7CiAJCWRldl9lcnIoZGV2LCAiJXMgZXJy
b3IgJWRcbiIsICJyZWFkIiwgdG1wKTsKIAkJcmV0dXJuIC1FSU87CiAJfQpAQCAtMTkwLDcgKzE4
NSw2IEBAIHN0YXRpYyBpbnQgZHMxMzA3X3NldF90aW1lKHN0cnVjdCBkZXZpY2UKIAkJdC0+dG1f
aG91ciwgdC0+dG1fbWRheSwKIAkJdC0+dG1fbW9uLCB0LT50bV95ZWFyLCB0LT50bV93ZGF5KTsK
IAotCSpidWYrKyA9IDA7CQkvKiBmaXJzdCByZWdpc3RlciBhZGRyICovCiAJYnVmW0RTMTMwN19S
RUdfU0VDU10gPSBCSU4yQkNEKHQtPnRtX3NlYyk7CiAJYnVmW0RTMTMwN19SRUdfTUlOXSA9IEJJ
TjJCQ0QodC0+dG1fbWluKTsKIAlidWZbRFMxMzA3X1JFR19IT1VSXSA9IEJJTjJCQ0QodC0+dG1f
aG91cik7CkBAIC0yMTUsMTggKzIwOSwxNCBAQCBzdGF0aWMgaW50IGRzMTMwN19zZXRfdGltZShz
dHJ1Y3QgZGV2aWNlCiAJCWJyZWFrOwogCX0KIAotCWRzMTMwNy0+bXNnWzFdLmZsYWdzID0gMDsK
LQlkczEzMDctPm1zZ1sxXS5sZW4gPSA4OwotCiAJZGV2X2RiZyhkZXYsICIlczogJTAyeCAlMDJ4
ICUwMnggJTAyeCAlMDJ4ICUwMnggJTAyeFxuIiwKIAkJIndyaXRlIiwgYnVmWzBdLCBidWZbMV0s
IGJ1ZlsyXSwgYnVmWzNdLAogCQlidWZbNF0sIGJ1Zls1XSwgYnVmWzZdKTsKIAotCXJlc3VsdCA9
IGkyY190cmFuc2Zlcih0b19pMmNfYWRhcHRlcihkczEzMDctPmNsaWVudC0+ZGV2LnBhcmVudCks
Ci0JCQkmZHMxMzA3LT5tc2dbMV0sIDEpOwotCWlmIChyZXN1bHQgIT0gMSkgewotCQlkZXZfZXJy
KGRldiwgIiVzIGVycm9yICVkXG4iLCAid3JpdGUiLCB0bXApOwotCQlyZXR1cm4gLUVJTzsKKwly
ZXN1bHQgPSBpMmNfc21idXNfd3JpdGVfaTJjX2Jsb2NrX2RhdGEoZHMxMzA3LT5jbGllbnQsIDAs
IDcsIGJ1Zik7CisJaWYgKHJlc3VsdCA8IDApIHsKKwkJZGV2X2VycihkZXYsICIlcyBlcnJvciAl
ZFxuIiwgIndyaXRlIiwgcmVzdWx0KTsKKwkJcmV0dXJuIHJlc3VsdDsKIAl9CiAJcmV0dXJuIDA7
CiB9CkBAIC0yNDYsNyArMjM2LDYgQEAgZHMxMzA3X252cmFtX3JlYWQoc3RydWN0IGtvYmplY3Qg
KmtvYmosIAogewogCXN0cnVjdCBpMmNfY2xpZW50CSpjbGllbnQ7CiAJc3RydWN0IGRzMTMwNwkJ
KmRzMTMwNzsKLQlzdHJ1Y3QgaTJjX21zZwkJbXNnWzJdOwogCWludAkJCXJlc3VsdDsKIAogCWNs
aWVudCA9IGtvYmpfdG9faTJjX2NsaWVudChrb2JqKTsKQEAgLTI1OSwyNCArMjQ4LDEwIEBAIGRz
MTMwN19udnJhbV9yZWFkKHN0cnVjdCBrb2JqZWN0ICprb2JqLCAKIAlpZiAodW5saWtlbHkoIWNv
dW50KSkKIAkJcmV0dXJuIGNvdW50OwogCi0JbXNnWzBdLmFkZHIgPSBjbGllbnQtPmFkZHI7Ci0J
bXNnWzBdLmZsYWdzID0gMDsKLQltc2dbMF0ubGVuID0gMTsKLQltc2dbMF0uYnVmID0gYnVmOwot
Ci0JYnVmWzBdID0gOCArIG9mZjsKLQotCW1zZ1sxXS5hZGRyID0gY2xpZW50LT5hZGRyOwotCW1z
Z1sxXS5mbGFncyA9IEkyQ19NX1JEOwotCW1zZ1sxXS5sZW4gPSBjb3VudDsKLQltc2dbMV0uYnVm
ID0gYnVmOwotCi0JcmVzdWx0ID0gaTJjX3RyYW5zZmVyKHRvX2kyY19hZGFwdGVyKGNsaWVudC0+
ZGV2LnBhcmVudCksIG1zZywgMik7Ci0JaWYgKHJlc3VsdCAhPSAyKSB7CisJcmVzdWx0ID0gaTJj
X3NtYnVzX3JlYWRfaTJjX2Jsb2NrX2RhdGEoY2xpZW50LCA4ICsgb2ZmLCBjb3VudCwgYnVmKTsK
KwlpZiAocmVzdWx0IDwgMCkKIAkJZGV2X2VycigmY2xpZW50LT5kZXYsICIlcyBlcnJvciAlZFxu
IiwgIm52cmFtIHJlYWQiLCByZXN1bHQpOwotCQlyZXR1cm4gLUVJTzsKLQl9Ci0JcmV0dXJuIGNv
dW50OworCXJldHVybiByZXN1bHQ7CiB9CiAKIHN0YXRpYyBzc2l6ZV90CkBAIC0yODQsOCArMjU5
LDcgQEAgZHMxMzA3X252cmFtX3dyaXRlKHN0cnVjdCBrb2JqZWN0ICprb2JqLAogCQljaGFyICpi
dWYsIGxvZmZfdCBvZmYsIHNpemVfdCBjb3VudCkKIHsKIAlzdHJ1Y3QgaTJjX2NsaWVudAkqY2xp
ZW50OwotCXU4CQkJYnVmZmVyW05WUkFNX1NJWkUgKyAxXTsKLQlpbnQJCQlyZXQ7CisJaW50CQkJ
cmVzdWx0OwogCiAJY2xpZW50ID0ga29ial90b19pMmNfY2xpZW50KGtvYmopOwogCkBAIC0yOTYs
MTEgKzI3MCwxMiBAQCBkczEzMDdfbnZyYW1fd3JpdGUoc3RydWN0IGtvYmplY3QgKmtvYmosCiAJ
aWYgKHVubGlrZWx5KCFjb3VudCkpCiAJCXJldHVybiBjb3VudDsKIAotCWJ1ZmZlclswXSA9IDgg
KyBvZmY7Ci0JbWVtY3B5KGJ1ZmZlciArIDEsIGJ1ZiwgY291bnQpOwotCi0JcmV0ID0gaTJjX21h
c3Rlcl9zZW5kKGNsaWVudCwgYnVmZmVyLCBjb3VudCArIDEpOwotCXJldHVybiAocmV0IDwgMCkg
PyByZXQgOiAocmV0IC0gMSk7CisJcmVzdWx0ID0gaTJjX3NtYnVzX3dyaXRlX2kyY19ibG9ja19k
YXRhKGNsaWVudCwgOCArIG9mZiwgY291bnQsIGJ1Zik7CisJaWYgKHJlc3VsdCA8IDApIHsKKwkJ
ZGV2X2VycigmY2xpZW50LT5kZXYsICIlcyBlcnJvciAlZFxuIiwgIm52cmFtIHdyaXRlIiwgcmVz
dWx0KTsKKwkJcmV0dXJuIHJlc3VsdDsKKwl9CisJcmV0dXJuIGNvdW50OwogfQogCiBzdGF0aWMg
c3RydWN0IGJpbl9hdHRyaWJ1dGUgbnZyYW0gPSB7CkBAIC0zMjUsMTEgKzMwMCwxMyBAQCBzdGF0
aWMgaW50IF9fZGV2aW5pdCBkczEzMDdfcHJvYmUoc3RydWN0CiAJc3RydWN0IGRzMTMwNwkJKmRz
MTMwNzsKIAlpbnQJCQllcnIgPSAtRU5PREVWOwogCWludAkJCXRtcDsKKwl1OAkJCSpidWY7CiAJ
Y29uc3Qgc3RydWN0IGNoaXBfZGVzYwkqY2hpcCA9ICZjaGlwc1tpZC0+ZHJpdmVyX2RhdGFdOwog
CXN0cnVjdCBpMmNfYWRhcHRlcgkqYWRhcHRlciA9IHRvX2kyY19hZGFwdGVyKGNsaWVudC0+ZGV2
LnBhcmVudCk7CiAKIAlpZiAoIWkyY19jaGVja19mdW5jdGlvbmFsaXR5KGFkYXB0ZXIsCi0JCQlJ
MkNfRlVOQ19JMkMgfCBJMkNfRlVOQ19TTUJVU19XUklURV9CWVRFX0RBVEEpKQorCQkJSTJDX0ZV
TkNfU01CVVNfV1JJVEVfQllURV9EQVRBIHwKKwkJCUkyQ19GVU5DX1NNQlVTX0kyQ19CTE9DSykp
CiAJCXJldHVybiAtRUlPOwogCiAJaWYgKCEoZHMxMzA3ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IGRzMTMwNyksIEdGUF9LRVJORUwpKSkKQEAgLTMzOCwzNSArMzE1LDIxIEBAIHN0YXRpYyBpbnQg
X19kZXZpbml0IGRzMTMwN19wcm9iZShzdHJ1Y3QKIAlkczEzMDctPmNsaWVudCA9IGNsaWVudDsK
IAlpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBkczEzMDcpOwogCi0JZHMxMzA3LT5tc2dbMF0u
YWRkciA9IGNsaWVudC0+YWRkcjsKLQlkczEzMDctPm1zZ1swXS5mbGFncyA9IDA7Ci0JZHMxMzA3
LT5tc2dbMF0ubGVuID0gMTsKLQlkczEzMDctPm1zZ1swXS5idWYgPSAmZHMxMzA3LT5yZWdfYWRk
cjsKLQotCWRzMTMwNy0+bXNnWzFdLmFkZHIgPSBjbGllbnQtPmFkZHI7Ci0JZHMxMzA3LT5tc2db
MV0uZmxhZ3MgPSBJMkNfTV9SRDsKLQlkczEzMDctPm1zZ1sxXS5sZW4gPSBzaXplb2YoZHMxMzA3
LT5yZWdzKTsKLQlkczEzMDctPm1zZ1sxXS5idWYgPSBkczEzMDctPnJlZ3M7Ci0KIAlkczEzMDct
PnR5cGUgPSBpZC0+ZHJpdmVyX2RhdGE7CiAKIAlzd2l0Y2ggKGRzMTMwNy0+dHlwZSkgewogCWNh
c2UgZHNfMTMzNzoKIAljYXNlIGRzXzEzMzk6Ci0JCWRzMTMwNy0+cmVnX2FkZHIgPSBEUzEzMzdf
UkVHX0NPTlRST0w7Ci0JCWRzMTMwNy0+bXNnWzFdLmxlbiA9IDI7Ci0KKwkJYnVmID0gJmRzMTMw
Ny0+cmVnc1tEUzEzMzdfUkVHX0NPTlRST0xdOwogCQkvKiBnZXQgcmVnaXN0ZXJzIHRoYXQgdGhl
ICJydGMiIHJlYWQgYmVsb3cgd29uJ3QgcmVhZC4uLiAqLwotCQl0bXAgPSBpMmNfdHJhbnNmZXIo
YWRhcHRlciwgZHMxMzA3LT5tc2csIDIpOworCQl0bXAgPSBpMmNfc21idXNfcmVhZF9pMmNfYmxv
Y2tfZGF0YShkczEzMDctPmNsaWVudCwKKwkJCQlEUzEzMzdfUkVHX0NPTlRST0wsIDIsIGJ1Zik7
CiAJCWlmICh0bXAgIT0gMikgewogCQkJcHJfZGVidWcoInJlYWQgZXJyb3IgJWRcbiIsIHRtcCk7
CiAJCQllcnIgPSAtRUlPOwogCQkJZ290byBleGl0X2ZyZWU7CiAJCX0KIAotCQlkczEzMDctPnJl
Z19hZGRyID0gMDsKLQkJZHMxMzA3LT5tc2dbMV0ubGVuID0gc2l6ZW9mKGRzMTMwNy0+cmVncyk7
Ci0KIAkJLyogb3NjaWxsYXRvciBvZmY/ICB0dXJuIGl0IG9uLCBzbyBjbG9jayBjYW4gdGljay4g
Ki8KIAkJaWYgKGRzMTMwNy0+cmVnc1swXSAmIERTMTMzN19CSVRfbkVPU0MpCiAJCQlpMmNfc21i
dXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgRFMxMzM3X1JFR19DT05UUk9MLApAQCAtMzg1LDkg
KzM0OCw5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGRzMTMwN19wcm9iZShzdHJ1Y3QKIAogcmVh
ZF9ydGM6CiAJLyogcmVhZCBSVEMgcmVnaXN0ZXJzICovCi0KLQl0bXAgPSBpMmNfdHJhbnNmZXIo
YWRhcHRlciwgZHMxMzA3LT5tc2csIDIpOwotCWlmICh0bXAgIT0gMikgeworCWJ1ZiA9IGRzMTMw
Ny0+cmVnczsKKwl0bXAgPSBpMmNfc21idXNfcmVhZF9pMmNfYmxvY2tfZGF0YShkczEzMDctPmNs
aWVudCwgMCwgOCwgYnVmKTsKKwlpZiAodG1wICE9IDgpIHsKIAkJcHJfZGVidWcoInJlYWQgZXJy
b3IgJWRcbiIsIHRtcCk7CiAJCWVyciA9IC1FSU87CiAJCWdvdG8gZXhpdF9mcmVlOwo=

--_002_C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DAPRIMBX101dom1_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--_002_C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DAPRIMBX101dom1_--
