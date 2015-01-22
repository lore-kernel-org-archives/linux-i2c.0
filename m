From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 22 Jan 2015 17:09:32 -0600
Message-ID: <CAL_JsqKYvcec=xWQM7_Dgrr5zmkefXqGCQvHwJ+uxNgfiv7fcw@mail.gmail.com>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150122144818.GG3413@katana> <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ@mail.gmail.com>
 <20150122150243.GI3413@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122150243.GI3413@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 22, 2015 at 9:02 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Jan 22, 2015 at 08:58:36AM -0600, Rob Herring wrote:
>> On Thu, Jan 22, 2015 at 8:48 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> > On Thu, Jan 15, 2015 at 08:33:18PM +0200, Pantelis Antoniou wrote:
>> >> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
>> >> This is required to avoid multi probing when using I2C and device
>> >> overlays containing a mux.
>> >> This patch is also more careful with the release of the adapter device
>> >> which caused a deadlock with muxes, and does not break the build
>> >> on !OF since the node flag accessors are not defined then.
>> >>
>> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>> >
>> > Applied to for-current, thanks!
>>
>> Ignoring my comments? It's not a big deal, but Pantelis did send out
>> the DT patch necessary for my suggestion[1]. It's needed in another
>> place now, too.
>
> Not sure if I saw this patch before...
>
> Is this DT patch targetted to for-next or for-current. Because this
> patch is a bugfix and needs to go into this cycle. I'll happily apply a
> cleanup patch to for-next then.

Feel free to apply it for 3.19 with my ack. You then want to pick up
v1 of this patch.

Rob
