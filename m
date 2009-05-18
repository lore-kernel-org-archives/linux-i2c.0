From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo@semihalf.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Mon, 18 May 2009 15:57:11 +0200
Message-ID: <200905181557.11766.kosmo@semihalf.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
	<4A028182.3040107@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <4A028182.3040107@grandegger.com>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
> setting for the MPC512x, which has been merged recently (see commit id
> f2bd5efe).

I have simple question about bus speed setting support. Existing =

implementation uses default safe speed if there is no 'clock-frequency' =

property in i2c node. Comments in code suggest that this behaviour is left =

for backward compatibility only. Should I make the 'clock-frequency'
property mandatory for a new type of I2C controller (MPC5121) ?

-- =

Best Regards.
Piotr Zi=EAcik
