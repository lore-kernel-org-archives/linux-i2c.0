From: Jochen Friedrich <jochen@scram.de>
Subject: Re: build breakage from of i2c helper patch
Date: Thu, 17 Apr 2008 11:25:12 +0200
Message-ID: <48071778.2000405@scram.de>
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>, Linux I2C <i2c@lm-sensors.org>, "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kumar,

> I'm guessing the "[POWERPC] i2c: OF helpers for the i2c API"
> 
> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commitdiff;h=612212a3f2f053ea68ce9cd16d3deeca7754e8c9
> 
> is causing this build failure:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/24375/

It looks like it. i2c-core needs to be compiled static for the OF bindings to work.
I guess in Kconfig "depends on OF && I2C" must be changed into "depends on OF && (I2C=y)"

On the other hand, i didn't test the patch without the dependent patches, so it might not work as expected:

http://patchwork.ozlabs.org/linuxppc/patch?id=17833
http://patchwork.ozlabs.org/linuxppc/patch?id=17834

or the original ones from Jean Delvare:

http://patchwork.ozlabs.org/linuxppc/patch?id=16282
http://patchwork.ozlabs.org/linuxppc/patch?id=16283
http://patchwork.ozlabs.org/linuxppc/patch?id=16284

Thanks,
Jochen
