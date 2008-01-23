From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for
	breaking out common code.
Date: Tue, 22 Jan 2008 20:02:13 -0700
Message-ID: <fa686aa40801221902u21856724ob146bf5ff8de8f78@mail.gmail.com>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123134654.cb5e249d.sfr@canb.auug.org.au>
	<9e4733910801221850k406f0985jd072876b681299da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <9e4733910801221850k406f0985jd072876b681299da@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On 1/22/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 1/22/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Adding -M or -C to the "git diff" should identify renames and
> > makes this sort of patch much easier to review.
>
> I use stgit, I'll ask them how to generate rename patches. The actual
> git diff is buried inside stgit somewhere.

>From the "stg mail --help" output:

  -O DIFF_OPTS, --diff-opts=DIFF_OPTS
                        options to pass to git-diff

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
