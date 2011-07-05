From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Allow i2c_add_numbered_adapter() to assign a bus id.
Date: Tue, 5 Jul 2011 07:31:20 -0600
Message-ID: <CACxGe6uDSS3eeah=+LO+u9ZV=pCjDLy2nYC3J_a8m-=QRgEeWw@mail.gmail.com>
References: <20110627185505.19423.64214.stgit@ponder> <BANLkTi=6zxPUwGZ5JHhRGRHHaEgvNgiaHQ@mail.gmail.com>
 <20110705105330.63c113c8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110705105330.63c113c8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <SWarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 5, 2011 at 2:53 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote=
:
> Hi Grant,
>
> Sorry for the late answer.
>
> On Mon, 27 Jun 2011 13:02:45 -0600, Grant Likely wrote:
>> On Mon, Jun 27, 2011 at 12:55 PM, Grant Likely
>> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> > Currently, if an i2c bus driver supports both static and dynamic b=
us
>> > ids, it needs to choose between calling i2c_add_numbered_adapter()=
 and
>> > i2c_add_adapter(). =A0This patch makes i2c_add_numbered_adapter()
>> > redirect to i2c_add_adapter() if the requested bus id is -1.
>> >
>> > Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>
>> Oops, forgot to edit the email before sending the patch.
>>
>> This patch is as-yet untested other than build testing, but I want t=
o
>> get feedback. =A0With the move to DT on ARM, there are going to be a=
 lot
>> more i2c bus drivers that need to support both static and dynamicall=
y
>> allocated busses, and it is very likely that it will be needed in th=
e
>> v3.1 merge window.
>>
>> Ben/Jean, *IF* this patch tests out okay, and *IF* I get an ack from
>> you, it will probably need to have this commit in my devicetree/next
>> branch. =A0If so, then I'll either need to commit it myself, or have=
 it
>> put into a separate topic branch that both of us can merge into our
>> trees. =A0What is your preference.
>>
>> John: this is the patch that I asked you to write earlier today, but=
 I
>> think one of the TI folks will run into the same issue, so I wanted =
to
>> get it drafted and onto the list ASAP.
>
> If this makes your life easier then I have no objection, you can go
> ahead. I don't expect any conflict with my tree as there is no i2c-co=
re
> work going on on my end at the moment. So you can just take it in you=
r
> tree and merge it yourself as you see fit.
>
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Thanks Jean, will do.

g.
