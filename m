From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 3/7] i2c: export bit-banging algo functions
Date: Tue, 28 Feb 2012 09:06:52 +0100
Message-ID: <20120228090652.627ac312@endymion.delvare>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
	<1329255445-6312-3-git-send-email-daniel.vetter@ffwll.ch>
	<20120227232040.0476d508@endymion.delvare>
	<20120227225223.GB1050@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120227225223.GB1050@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI@freedesktop.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, Development <dri-devel@lists.freedesktop.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Feb 2012 23:52:23 +0100, Daniel Vetter wrote:
> On Mon, Feb 27, 2012 at 11:20:40PM +0100, Jean Delvare wrote:
> > If you need to hot-switch between hardware and bit-banged I2C, I suggest
> > that you lock the bus while doing so, to avoid switching while a
> > transaction is in progress. This can be achieved with
> > i2c_lock_adapter() and i2c_unlock_adapter().
> 
> The drm/i915 xfer function is currently protected by a single mutex
> (because the hw i2c controller can only be used on one bus at a time). So
> I think we're covered. Also we do the fallback in our xfer function when
> we notice that things don't quite work as they should, so we actually want
> to switch while a transfer is in progress. Dunno whether that's the best
> approach, but the current code is structured like this.

This seems perfectly sane.

> (...)
> I've noticed that the the bit-banging algo does some test upon
> registration but figured that it's not worth the fuss to add a new init
> function that avoids the registration.

Note that thanks to the way things are implemented in i2c-algo-bit,
you'd really only have to write a new wrapper around
__i2c_bit_add_bus(), so this is really only 1 line of code. That being
said, I am not insisting, it's really up to you.

-- 
Jean Delvare
