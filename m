From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for
	breaking out common code.
Date: Tue, 22 Jan 2008 22:09:17 -0500
Message-ID: <9e4733910801221909s49c171cdm880a7e2eaafb83b4@mail.gmail.com>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123134654.cb5e249d.sfr@canb.auug.org.au>
	<9e4733910801221850k406f0985jd072876b681299da@mail.gmail.com>
	<fa686aa40801221902u21856724ob146bf5ff8de8f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <fa686aa40801221902u21856724ob146bf5ff8de8f78@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On 1/22/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 1/22/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 1/22/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Adding -M or -C to the "git diff" should identify renames and
> > > makes this sort of patch much easier to review.
> >
> > I use stgit, I'll ask them how to generate rename patches. The actual
> > git diff is buried inside stgit somewhere.
>
> From the "stg mail --help" output:
>
>   -O DIFF_OPTS, --diff-opts=DIFF_OPTS
>                         options to pass to git-diff

I found that one, there doesn't appear to be a way to set it
permanently via the config file. I asked them to add the option.
Here's the patch with -M set, I'll make sure and set it on the final
version. These patches apply on top of Jean's patch adding module
loading to i2c, which apply on top of his 2.6.25 tree.

Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 drivers/i2c/busses/Makefile      |    2
 drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------------
 3 files changed, 423 insertions(+), 421 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
 delete mode 100644 drivers/i2c/busses/i2c-mpc.c


diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ea7068f..171800d 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the i2c bus drivers.
 #

+i2c-mpc-objs	:= i2c-mpc-drv.o
+
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc-drv.c
similarity index 100%
rename from drivers/i2c/busses/i2c-mpc.c
rename to drivers/i2c/busses/i2c-mpc-drv.c

-- 
Jon Smirl
jonsmirl@gmail.com
