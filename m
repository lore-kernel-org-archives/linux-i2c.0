From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: True Parallel Port Interface for Bit-banging?
Date: Wed, 26 Oct 2016 02:04:01 +0200
Message-ID: <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org>
In-Reply-To: <580F72AF.9070900@laposte.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-parport/>
List-Post: <mailto:linux-parport@lists.infradead.org>
List-Help: <mailto:linux-parport-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-parport" <linux-parport-bounces@lists.infradead.org>
Errors-To: linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-parport@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, philb@gnu.org, tim@cyberelk.net
List-Id: linux-i2c@vger.kernel.org

On 25.10.2016 16:56, Sebastian Frias wrote:
> On 10/25/2016 04:29 PM, Wolfram Sang wrote:
>>> The virtualisation idea is not good then?
>>
>> It is not that. I think good old DOSEMU could do that. Bit-Banging ports
>> can be timing critical, though, and in this department virtualization
>> solutions often fail.
>>
> 
> Thanks.
> I understand your point, but I'm guessing that the big-banging routine (or the
> protocol to be used) should be time-independent in order to run on different
> real HW PCs, right? Otherwise a 386DX and a 486DX2 could behave differently,
> right?
> 
> Or is the "timing issue" you talk about more related to unpredictable
> latencies due to the way the SW virtualisation works?
> 
> What about emulation? Do you think emulation would be more predictable?

I don't have experience with bit-banging parallel port but I do have
some with bit-banging PC serial ports (which should be very similar)
and can confirm that old DOS software can be *very* fragile with regard
to timing.
I have tried dosemu, dosbox and as far I remember also VirtualBox
with an old, DOS car service app.
Wasn't able to make it communicate until I booted true DOS.
That machine had old-style ISA serial ports so it was possible.

You also have asked previously whether laptop port would work.
On my current HP Elitebook ports of both types are wired to Super IO,
and using PC standard IO port and interrupt numbers.

I also remember that at least on ThinkPads and HP Compaqs that I had
contact with (these were laptops from 10+ years ago) both serial and
parallel ports were wired to Super IO chip (including ones available
only via port replicator).
So they were also at PC standard resources.

However, other issue is that sometimes such ports are inactive by
default (don't respond) until enabled by PnP.

This is also a problem with PCMCIA cards - they are disabled
by default.
I have Argosy 2xRS232 PCMCIA card and remember it came with
DOS driver which could enable them on I/O port close to standard
one - this was one of their major selling points.
So your ExpressCard would probably need similar software.

Maciej
