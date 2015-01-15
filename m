From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 15 Jan 2015 21:12:36 +0200
Message-ID: <18134341-FA1D-4ED6-8ED3-E4BF8F90B47E@konsulko.com>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com> <20150115185545.GA20251@roeck-us.net>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115185545.GA20251-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

> On Jan 15, 2015, at 20:55 , Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>=20
> On Thu, Jan 15, 2015 at 08:33:18PM +0200, Pantelis Antoniou wrote:
>> Mark (and unmark) device nodes with the POPULATE flag as appropriate=
=2E
>> This is required to avoid multi probing when using I2C and device
>> overlays containing a mux.
>> This patch is also more careful with the release of the adapter devi=
ce
>> which caused a deadlock with muxes, and does not break the build
>> on !OF since the node flag accessors are not defined then.
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>> ---
>> drivers/i2c/i2c-core.c | 18 +++++++++++++++++-
>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 39d25a8..1d44e3a 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1122,6 +1122,10 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
>>  */
>> void i2c_unregister_device(struct i2c_client *client)
>> {
>> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
>=20
> Hi Pantelis,
>=20
> I thought I read a note somewhere a couple of days ago suggesting tha=
t
> CONFIG_OF_DYNAMIC would go away soon. Also, of_node_clear_flag is def=
ined
> in #ifdef CONFIG_OF, and AFAICS none of the other callers set OF_POPU=
LATED
> in the context of CONFIG_OF_DYNAMIC. Given that, wouldn't it be bette=
r
> to use CONFIG_OF ?
>=20
> Thanks,
> Guenter
>=20

Well, I thought about it. Thing is that the notifier is under CONFIG_DY=
NAMIC,
and it seems it=E2=80=99s natural to be that way.

When we move to always enabling CONFIG_DYNAMIC the change to CONFIG_OF =
will be
part of the conversion.

Regards

=E2=80=94 Pantelis

>> +	if (client->dev.of_node)
>> +		of_node_clear_flag(client->dev.of_node, OF_POPULATED);
>> +#endif
>> 	device_unregister(&client->dev);
>> }
>> EXPORT_SYMBOL_GPL(i2c_unregister_device);
>> @@ -1441,8 +1445,11 @@ static void of_i2c_register_devices(struct i2=
c_adapter *adap)
>>=20
>> 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
>>=20
>> -	for_each_available_child_of_node(adap->dev.of_node, node)
>> +	for_each_available_child_of_node(adap->dev.of_node, node) {
>> +		if (of_node_test_and_set_flag(node, OF_POPULATED))
>> +			continue;
>> 		of_i2c_register_device(adap, node);
>> +	}
>> }
>>=20
>> static int of_dev_node_match(struct device *dev, void *data)
>> @@ -1976,6 +1983,11 @@ static int of_i2c_notify(struct notifier_bloc=
k *nb, unsigned long action,
>> 		if (adap =3D=3D NULL)
>> 			return NOTIFY_OK;	/* not for us */
>>=20
>> +		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
>> +			put_device(&adap->dev);
>> +			return NOTIFY_OK;
>> +		}
>> +
>> 		client =3D of_i2c_register_device(adap, rd->dn);
>> 		put_device(&adap->dev);
>>=20
>> @@ -1986,6 +1998,10 @@ static int of_i2c_notify(struct notifier_bloc=
k *nb, unsigned long action,
>> 		}
>> 		break;
>> 	case OF_RECONFIG_CHANGE_REMOVE:
>> +		/* already depopulated? */
>> +		if (!of_node_check_flag(rd->dn, OF_POPULATED))
>> +			return NOTIFY_OK;
>> +
>> 		/* find our device by node */
>> 		client =3D of_find_i2c_device_by_node(rd->dn);
>> 		if (client =3D=3D NULL)
>> --=20
>> 1.7.12
