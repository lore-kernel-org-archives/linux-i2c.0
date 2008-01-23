From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation
	for breaking out common code.
Date: Tue, 22 Jan 2008 21:50:13 -0500
Message-ID: <9e4733910801221850k406f0985jd072876b681299da@mail.gmail.com>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123134654.cb5e249d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080123134654.cb5e249d.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/22/08, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org> wrote:
> Hi Jon,
>
> On Tue, 22 Jan 2008 21:09:12 -0500 Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.
> >
> > Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >
> >  drivers/i2c/busses/Makefile      |    2
> >  drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------------
> >  3 files changed, 423 insertions(+), 421 deletions(-)
> >  create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
> >  delete mode 100644 drivers/i2c/busses/i2c-mpc.c
>
> Adding -M or -C to the "git diff" should identify renames and
> makes this sort of patch much easier to review.

I use stgit, I'll ask them how to generate rename patches. The actual
git diff is buried inside stgit somewhere.

>
> --
> Cheers,
> Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
> http://www.canb.auug.org.au/~sfr/
>
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
