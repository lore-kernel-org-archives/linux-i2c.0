From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/2] i2c-ibm_iic driver
Date: Sat, 16 Feb 2008 09:20:20 +0100
Message-ID: <20080216092020.2a37e2d3@hyperion.delvare>
References: <4784FED1.2040206@pikatech.com> <47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
	<47B66179.9010501@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <47B66179.9010501@pikatech.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 15 Feb 2008 23:07:21 -0500, Sean MacLennan wrote:
> Jean Delvare wrote:
> > Please split your patch into logical parts:
> > * Whitespace and coding-style cleanups
> > * Other cleanups (e.g. changing the log levels)
> > * Add OF support
> >   
> Here is the first patch with everything except the OF support. Really 
> all I did was change the log levels based on feedback from linxppc-dev.
> 
> Cheers,
>    Sean
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Applied, thanks.

-- 
Jean Delvare
