From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Mon, 26 Jan 2015 13:27:07 -0600
Message-ID: <CAL_JsqL9m-r3aJhiwSY61xXG9CbkHfD7RqrbNG=mBJnGD_-YPw@mail.gmail.com>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150122144818.GG3413@katana> <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ@mail.gmail.com>
 <20150122150243.GI3413@katana> <CAL_JsqKYvcec=xWQM7_Dgrr5zmkefXqGCQvHwJ+uxNgfiv7fcw@mail.gmail.com>
 <20150124042623.GB1190@katana> <DEFFB75F-347B-43F9-98E5-BBD019276A37@konsulko.com>
 <20150126155550.GB13494@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150126155550.GB13494@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 26, 2015 at 9:55 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote=
:
> On Sat, Jan 24, 2015 at 09:16:16AM +0200, Pantelis Antoniou wrote:
>> Hi Wolfram,
>>
>> > On Jan 24, 2015, at 06:26 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote=
:
>> >
>> >
>> >> Feel free to apply it for 3.19 with my ack. You then want to pick=
 up
>> >> v1 of this patch.
>> >
>> > Sigh, I give up, this is too confusing. I don't know which one is =
V1,
>> > they are not numbered in any way. And I have been holding back my =
pull
>> > request for too long already.
>> >
>> > I'll drop this patch. Whatever should be applied should be resent,
>> > mentioning the release it is aimed for and how the planning/depend=
ency
>> > on the DT patch is.
>> >
>>
>> Nooooo! This is a bugfix for 3.19 :)
>>
>> I=E2=80=99m resending the original patch; the dependency is on
>>
>>       "of: Empty node & property flag accessors when !OF=E2=80=9D
>>
>> https://lkml.org/lkml/2015/1/21/602
>
> Which is going in when?

Can you apply it since it is a dependency on this bug fix patch.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
