From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Tue, 19 May 2009 10:10:42 +0200
Message-ID: <4A126982.8010002@grandegger.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<200905181557.11766.kosmo@semihalf.com>
	<4A1170B0.5080203@grandegger.com>
	<200905190947.22972.kosmo@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <200905190947.22972.kosmo@semihalf.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: =?ISO-8859-2?Q?Piotr_Zi=EAcik?= <kosmo@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Piotr Zi=EAcik wrote:
> Monday 18 May 2009 16:29:04 Wolfgang Grandegger napisa=B3(a):
>>> I have simple question about bus speed setting support. Existing
>>> implementation uses default safe speed if there is no 'clock-frequency'
>>> property in i2c node. Comments in code suggest that this behaviour is
>>> left for backward compatibility only. Should I make the 'clock-frequenc=
y'
>>> property mandatory for a new type of I2C controller (MPC5121) ?
>> I don't think so, for the same backward compatibility reason as for the
>> other boards. But the DTS file might be changed to use clock-frequency.
> =

> In my opinion implementing "backward compatilility" for MPC5121 is not go=
od
> idea. MPC5121 I2C support is completly new thing in mainline. Simply, the=
re is =

> no DTS with which I have to be compatible. Adding backward compatibility
> with nothing may be confusing.

There is a port for the  MPC5121 in mainline since 2.6.25 including DTS
file:

http://lxr.linux.no/linux+v2.6.25/arch/powerpc/boot/dts/mpc5121ads.dts

If it was really usable or even used is another question. But it's fine
for me be more restrictive, e.g. print a warning when save values are
selected.

Wolfgang.
