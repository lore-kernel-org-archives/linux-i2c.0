From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add the of_find_i2c_device_by_node function
Date: Mon, 20 Oct 2008 16:19:56 +1100
Message-ID: <1224479996.7654.130.camel@pasglop>
References: <20081019140040.32281.65209.stgit@terra>
	<20081019212034.GA8224@oksana.dev.rtsoft.ru>
	<9e4733910810191450t36cbe120y106d18f71cb3163b@mail.gmail.com>
	<20081019220352.GA19539@oksana.dev.rtsoft.ru>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081019220352.GA19539@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2008-10-20 at 02:03 +0400, Anton Vorontsov wrote:
> > This is the original mail....
> > http://lkml.org/lkml/2008/6/13/290
> > http://lkml.org/lkml/2008/6/12/8
> > I can't find the ones patching i2c.
> 
> Well, I didn't disagree with the change. I think this is good change
> (and good catch, btw).
> 
> Just mention it in the patch description (or better yet, you could send
> a separate patch for this particular issue, it seems quite serious).

Yes, it should most definitely be a separate patch.

Cheers,
Ben.
