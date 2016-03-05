From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/8] i2c mux cleanup and locking update
Date: Sat, 5 Mar 2016 17:48:55 +0000
Message-ID: <56DB1C07.4040008@kernel.org>
References: <1452265496-22475-1-git-send-email-peda@lysator.liu.se>
 <20160302172904.GC5439@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160302172904.GC5439@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Olli Salonen <olli.salonen-X3B1VOXEql0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/03/16 17:29, Wolfram Sang wrote:
> On Fri, Jan 08, 2016 at 04:04:48PM +0100, Peter Rosin wrote:
>> From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>>
>> Hi!
>>
>> [doing a v3 even if there is no "big picture" feedback yet, but
>>  previous versions has bugs that make them harder to test than
>>  needed, and testing is very much desired]
>>
>> I have a pair of boards with this i2c topology:
>>
>>                        GPIO ---|  ------ BAT1
>>                         |      v /
>>    I2C  -----+------B---+---- MUX
>>              |                   \
>>            EEPROM                 ------ BAT2
>>
>> 	(B denotes the boundary between the boards)
>>
>> The problem with this is that the GPIO controller sits on the same i2c bus
>> that it MUXes. For pca954x devices this is worked around by using unlocked
>> transfers when updating the MUX. I have no such luck as the GPIO is a general
>> purpose IO expander and the MUX is just a random bidirectional MUX, unaware
>> of the fact that it is muxing an i2c bus, and extending unlocked transfers
>> into the GPIO subsystem is too ugly to even think about. But the general hw
>> approach is sane in my opinion, with the number of connections between the
>> two boards minimized. To put is plainly, I need support for it.
>>
>> So, I observe that while it is needed to have the i2c bus locked during the
>> actual MUX update in order to avoid random garbage on the slave side, it
>> is not strictly a must to have it locked over the whole sequence of a full
>> select-transfer-deselect operation. The MUX itself needs to be locked, so
>> transfers to clients behind the mux are serialized, and the MUX needs to be
>> stable during all i2c traffic (otherwise individual mux slave segments
>> might see garbage).
>>
>> This series accomplishes this by adding code to i2c-mux-gpio and
>> i2c-mux-pinctrl that determines if all involved devices used to update the
>> mux are controlled by the same root i2c adapter that is muxed. When this
>> is the case, the select-transfer-deselect operations should be locked
>> individually to avoid the deadlock. The i2c bus *is* still locked
>> during muxing, since the muxing happens as part of i2c transfers. This
>> is true even if the MUX is updated with several transfers to the GPIO (at
>> least as long as *all* MUX changes are using the i2s master bus). A lock
>> is added to the mux so that transfers through the mux are serialized.
>>
>> Concerns:
>> - The locking is perhaps too complex?
>> - I worry about the priority inheritance aspect of the adapter lock. When
>>   the transfers behind the mux are divided into select-transfer-deselect all
>>   locked individually, low priority transfers get more chances to interfere
>>   with high priority transfers.
>> - When doing an i2c_transfer() in_atomic() context or with irqs_disabled(),
>>   there is a higher possibility that the mux is not returned to its idle
>>   state after a failed (-EAGAIN) transfer due to trylock.
>> - Is the detection of i2c-controlled gpios and pinctrls sane (i.e. the
>>   usage of the new i2c_root_adapter() function in 8/8)?
>>
>> To summarize the series, there's some i2c-mux infrastructure cleanup work
>> first (I think that part stands by itself as desireable regardless), the
>> locking changes are in the last three patches of the series, with the real
>> meat in 8/8.
>>
>> PS. needs a bunch of testing, I do not have access to all the involved hw
> 
> I want to let you know that I am currently thinking about this series.
> 
> There seems to be a second occasion where it could have helped AFAICT.
> http://patchwork.ozlabs.org/patch/584776/ (check my comments there from
> yesterday and today)
> 
> First of all, really thank you that you tried to find the proper
> solution and went all the way for it. It is easy to do a fire&forget
> hack here, but you didn't.
> 
> I hope you understand, though, that I need to make a balance between
> features and complexity in my subsystem to have maintainable and stable
> code.
> 
> As I wrote in the mentioned thread already: "However, I am still
> undecided if that series should go upstream because it makes the mux
> code another magnitude more complex. And while this seems to be the
> second issue which could be fixed by that series, both issues seem to
> be corner cases, so I am not sure it is worth the complexity."
> 
> And for the cleanup series using struct mux_core. It is quite an
> intrusive change and, frankly, the savings look surprisingly low. I
> would have expected more, but you never find out until you do it. So, I
> am unsure here as well.
> 
> I am not decided and open for discussion. This is just where we are
> currently. All interested parties, I am looking forward to more
> thoughts.
> 
> Thanks,
Perhaps it's one to let sit into at least the next cycle (and get some testing
on those media devices if we can) but, whilst it is fiddly the gains seen in
individual drivers (like the example Peter put in response to the V4 series)
make it look worthwhile to me.  Also, whilst the invensense part is plain odd
in many ways, the case Peter had looks rather more normal.

At the end of the day, sometimes fiddly problems need fiddly code. 
(says a guy who doesn't have to maintain it!)

It certainly helps that Peter has done a thorough job, broken the patches
up cleanly and provided clean descriptions of what he is doing.

Jonathan
> 
>    Wolfram
> 
