From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/3] i2c: Use the standard, alias-based
	device/driver  matching scheme
Date: Mon, 21 Jan 2008 13:34:57 +0100
Message-ID: <20080121133457.4438a494@hyperion.delvare>
References: <20080121112517.6fe35a89@hyperion.delvare>
	<479478C7.5060807@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <479478C7.5060807@assembler.cz>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 21 Jan 2008 11:49:43 +0100, Rudolf Marek wrote:
> > Note: all the arm and powerpc stuff is untested.
> 
> We at http://sysgo.com have some demo server, where you can access embedded 
> systems remotely (via VNC to a server with cross tools (ELinOS)  + serial console),
> there is 2.6.22 kernel, but I think the i2c core can be replaced. I think some 
> PPC and ARMs are connected there. I will ask if you can get access to it if you 
> are interested.

Thanks for the proposal, but in general I think it makes more sense
that people who are familiar with these architectures test the patches
themselves. That's less work for me, and they'll do a better job anyway.

-- 
Jean Delvare
