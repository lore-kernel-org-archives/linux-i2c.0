From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on the same bus
Date: Fri, 31 Oct 2014 14:59:39 -0700
Message-ID: <5454064B.10000@roeck-us.net>
References: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com>	<20141031210301.GA4169@katana>	<5453FC86.1080408@roeck-us.net> <CAB0SmAG1r-EUFrDAjuh14uYQYc_typV4+JbfkUvCGX+=_09QmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAB0SmAG1r-EUFrDAjuh14uYQYc_typV4+JbfkUvCGX+=_09QmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 10/31/2014 02:45 PM, Martin Belanger wrote:
> Hi all, and thanks for your response.
>
> You are correct Guenter.  We need to address both i2c- and gpio-based
> multiplexers.  You and Jean suggested the following solution:
>
> I2C Mux:  i2c-N-mux-i2c-XX (chan_id M)
> GPIO Mux: i2c-N-mux-gpio-XX (chan_id M)
>
Too long ago to remember.

> Where XX is the i2c address or the first GPIO pin number.  This
> ensures unique IDs for both technologies.
>
> Adding a parameter to i2c_add_mux_adapter() (as you and Jean
> suggested) would solve the problem.  Basically, we pass a unique id
> string (e.g. "-i2c-XX" or "-gpio-XX") to the API, which then adds to
> the "name" as described above. In cases where a unique id is not
> required, we can simply pass NULL to i2c_add_mux_adapter().  Here's an
> example of what the new API would look like:
>
> struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>      struct device *mux_dev,
>      void *mux_priv, u32 force_nr, u32 chan_id,
>      unsigned int class,
>      int (*select) (struct i2c_adapter *,
>            void *mux_dev, u32 chan_id),
>      int (*deselect) (struct i2c_adapter *,
>      void *mux_dev, u32 chan_id),
>      const char *explicit_id);
>
> The parameter explicit_id gets used as follows:
>
> if (NULL == explicit_id)

Personally, I would never accept code like that; it just confuses me
to see the constant first in an expression.

API-wise I am fine with the proposed change, except I would probably
move the new argument ahead of chan_id and name it mux_id.

Guenter

>      explicit_id = "";
> snprintf(priv->adap.name, sizeof(priv->adap.name),
>      "i2c-%d-mux%s (chan_id %d)", i2c_adapter_id(parent), explicit_id, chan_id);
>
> If it's OK will all parties, I can submit a patch for it (and I'll
> make sure to reference Guenter and Jean as the designers).  This,
> however, is a first for me.  I read all the documents about submitting
> patches.  I was just wondering if I should submit against the current
> 3.18 development or some other "stable" releases.
>
> Regards,
> Martin
> Martin Belanger
> Sr. Software Engineer
> 1383 North McDowell Blvd.
> Petaluma, CA 94954
> M(707) 481-3392
> Emartin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org
> www.cyaninc.com
>
>
> On Fri, Oct 31, 2014 at 2:17 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>> On 10/31/2014 02:03 PM, Wolfram Sang wrote:
>>>
>>> Hi,
>>>
>>> On Mon, Oct 27, 2014 at 11:46:01AM -0700, Martin Belanger wrote:
>>>>
>>>> This is regarding a series of emails between Guenter Roeck and Jean
>>>> Delvare titled "Problem with multiple i2c multiplexers on one bus, and
>>>> mux bus naming" sent in November 2013. Ref:
>>>> http://thread.gmane.org/gmane.linux.drivers.i2c/16980
>>>
>>>
>>> Please CC those people then, too. That helps getting their attention.
>>> I've done this now.
>>>
>>>> I'm having the same problem with multiple PCA954x multiplexers on the
>>>> same bus and there is no way to tell them apart just by looking at the
>>>> "name" file.
>>>>
>>>> There was a suggestion to change the name from "i2c-N-mux (chan_id M)"
>>>> to "i2c-N-mux-XX (chan_id M)" or even "i2c-N-mux-i2c-XX (chan_id M)",
>>>> where XX is the multiplexer's i2c address. That would solve my
>>>> problem, but unfortunately it looks like Guenter never submitted the
>>>> patch (or maybe it was rejected?).
>>>
>>>
>>> It just dropped off :( But you guys have my attention now, let's fix
>>> this issue for 3.19! I am just reading through the old mails and will
>>> think about it. Input is welcome.
>>>
>> I didn't follow up on the issue since it was not an immediate concern,
>> and my proposed solution had some problems. If I remember correctly,
>> one of the problems was that the multiplexer does not have to be an
>> i2c chip. In that case XX would be unknown and/or have to be omitted.
>>
>> Guenter
>>
>>
>>>> I would like to submit a similar change, but I was thinking of adding
>>>> a module parameter so that the change is not the default behavior.
>>>> The idea is to preserve backward compatibility for applications that
>>>> don't require this fix. For example, modprobe i2c-dev
>>>> explicit_mux_id=1 would use i2c-N-mux-i2c-XX (chan_id M), whereas
>>>> modprobe i2c-dev would default to the current behavior: i.e. i2c-N-mux
>>>> (chan_id M).
>>>
>>>
>>> I don't like the need to set a module parameter to fix a flaw. I do
>>> consider changing the ABI to have better strings in "name". But as said,
>>> I need to think about it a little more...
>>>
>>> Thanks,
>>>
>>>      Wolfram
>>>
>>
>
