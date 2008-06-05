From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 11:05:02 +0200
Message-ID: <20080605110502.76f0f606@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
	<9e4733910806041228i330e145q439d3ee43494f4c4@mail.gmail.com>
	<20080604233335.13459512@hyperion.delvare>
	<9e4733910806041611l41832e07p4f55424be0ef5ea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041611l41832e07p4f55424be0ef5ea0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Wed, 4 Jun 2008 19:11:11 -0400, Jon Smirl wrote:
> On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >  One thing that we could consider though is merging i2c_listener into
> >  i2c_driver. For some reason I had not considered it - but I somehow
> >  expect funny locking issues if we do that.
> 
> We are not far apart on this proposal if you combine the
> class/address_data fields into i2c_driver 

Yes.

> and then use the existing probe function instead of detect().

No. Again, detect() creates the very device that probe() will be called
on, so merging detect() into probe() is, say, like dividing by 0.

(OK, not my most direct metaphor of the day - oh well ;))

> The i2c_client struct already has
> an address field. A driver would then check to see if there was
> hardware at the i2c_client.address and return false if it is not
> there. i2c core would just reuse the i2c_client struct with the next
> address and do another probe.

Out of curiosity, what would be the name of the device backing that
i2c_client? The device's name is what the driver core uses to know
which driver's probe() method needs to be called.

Maybe I'm just not seeing what you want to do. I'll be happy to see a
(tested) patch implementing your idea though. If you can come up with
something that works and has advantages over what I proposed, I'll
certainly consider it.

> Operations on an adapter need to be serialized but I thought the
> adapters already supported that. If they don't they need to be fixed
> anyway because of the BKL removal.

Yes, the operations on each adapter are already serialized, no problem
with this.

> (...)
> I don't think believe devices should need attach/detach adapter
> functions. If they do, there is probably some other way to achieve the
> same effect without needing the functions.

Care to enlighten me on what this other way would be? It's easy to
claim this of pretty much everything, but that's not valuable without
details on the "other way", sorry.

On top of that, you'd also need to explain why adapter_attach and
adapter_detach are bad, before claiming that they should be replaced by
something else. I am worried about the use that is done of these
callbacks at the moment, not by the callbacks themselves. If there's a
legitimate use of them (I still need to check the V4L/DVB drivers) I
see no reason to remove them.

> i2c-dev may need access to
> some i2c core structures to avoid the need for these calls.

That's certainly a possibility, yes, and I'll look into this if it
turns out that i2c-dev is the last user of any part of i2c_driver. But
then I wonder why i2c-dev was implemented the way it was, if all it
needed was access to some i2c-core internals.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
