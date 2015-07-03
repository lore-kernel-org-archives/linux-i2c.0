From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC 1/3] of: make of_mutex public
Date: Fri, 3 Jul 2015 09:54:47 +0300
Message-ID: <8FECDF89-828C-4F8F-A141-B2E1EF2E2B24@konsulko.com>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de> <1435700651-3543-2-git-send-email-wsa@the-dreams.de> <CAL_Jsq+-Tx=hwj9ScXBXeGxNwHhq-Lpe-5Kzd-Tu_SNue2aWTA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+-Tx=hwj9ScXBXeGxNwHhq-Lpe-5Kzd-Tu_SNue2aWTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

+Grant

Hi Rob,

> On Jul 3, 2015, at 07:43 , Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>=20
> +Pantelis
>=20
> On Tue, Jun 30, 2015 at 4:44 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wro=
te:
>> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>>=20
>> If we want to use OF_DYNAMIC features outside the of framework, we n=
eed
>> to access this lock. If OF maintainers don't like exporting, we can
>> maybe create accessor functions that we can use?
>=20
> It looks like you are just taking the mutex around various
> of_changeset_* calls. We should either split the mutex into of_mutex
> for core and changesets and an overlay mutex for overlays, or we need
> to do the typical pattern of having changeset functions having locked
> and unlocked versions for external and internal (overlays) use.
>=20

IIRC we had an argument with Grant just about that. The original
overlays patches did use a two level locking scheme, a changeset specif=
ic=20
mutex, and a global transaction mutex.

They were dropped after Grant=E2=80=99s request.

>> +
>> +/**
>> + * struct of_transaction - transaction tracker structure
>> + *
>> + * @lock:	lock for accessing the te_list and state entries
>> + * @te_list:	list_head for the transaction entries
>> + * @state:	State of the transaction
>> + *
>> + * Transactions are a convenient way to apply bulk changes to the
>> + * live tree. In case of an error, changes are rolled-back.
>> + * Transactions live on after initial application, and if not
>> + * destroyed after use, they can be reverted in one single call.
>> + */
>> +struct of_transaction {
>> +	struct mutex lock;
>=20
> What's the lock for? There will only ever by a single transaction in
> flight at any given time, and when a transaction is /not/ in flight, =
it
> is completely owned by the caller. I see no condition where there nee=
ds
> to be a lock just for the of_transaction structure.

What is it that we=E2=80=99re trying to do here? What is the use case?

> Rob
>=20

Regards

=E2=80=94 Pantelis

>> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>> ---
>> drivers/of/of_private.h | 1 -
>> include/linux/of.h      | 2 ++
>> 2 files changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 8e882e706cd8c6..f92ec41efb5dfd 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -31,7 +31,6 @@ struct alias_prop {
>>        char stem[0];
>> };
>>=20
>> -extern struct mutex of_mutex;
>> extern struct list_head aliases_lookup;
>> extern struct kset *of_kset;
>>=20
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index b871ff9d81d720..f0464efcbdc5aa 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -32,6 +32,8 @@
>> typedef u32 phandle;
>> typedef u32 ihandle;
>>=20
>> +extern struct mutex of_mutex;
>> +
>> struct property {
>>        char    *name;
>>        int     length;
>> --
>> 2.1.4
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
