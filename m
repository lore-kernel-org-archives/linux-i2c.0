From: Sebastian Frias <sf84@laposte.net>
Subject: True Parallel Port Interface for Bit-banging?
Date: Tue, 25 Oct 2016 13:21:38 +0200
Message-ID: <580F4042.5070201@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-parport/>
List-Post: <mailto:linux-parport@lists.infradead.org>
List-Help: <mailto:linux-parport-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-parport>,
 <mailto:linux-parport-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-parport" <linux-parport-bounces@lists.infradead.org>
Errors-To: linux-parport-bounces+linux-parport-2=m.gmane.org@lists.infradead.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: philb@gnu.org, Jean Delvare <jdelvare@suse.com>, linux-parport@lists.infradead.org, tim@cyberelk.net, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

(NOTE: I also included "I2C over Parallel Port" maintainers in CC because
it seems they do bit-banging for it)

I would guess this question may have been asked before but I did not find references
to an answer, sorry for repeating if that's the case.

I have a legacy application that requires a True Parallel port (ISA compatible)
for bit-banging.
As you know, most computers nowadays do not include a True Parallel port anymore.

There are ExpressCard adaptors, but their base address is not ISA compliant
(378h, 278h).

The legacy application is DOS, so I was thinking of virtualising it under Linux
so that Linux works at ExpressCard address, hoping that the port would end up
being exposed to the virtualised DOS at the right (ISA-legacy) address.

Would that make sense and/or be feasible? Are there better/easier solutions?

Alternatively, does anybody knows if the Parallel Port available thru Laptop
docking stations (Dell, HP, Thinkpad, etc.) are True Parallel Ports (ISA
compatible)?

Thanks in advance.
Best regards,

Sebastian
