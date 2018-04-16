From: Andrew Worsley <amworsley@gmail.com>
Subject: (unknown)
Date: Mon, 16 Apr 2018 11:22:47 +1000
Message-ID: <20180416012248.25891-1-amworsley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Subject: 
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: harinik@xilinx.com, APANDEY@xilinx.com, asarkar@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


  This patch clears the remaining i2c buffer overrun problems that I see in my
hardware.  When run at 200kHz over 2 days and 17 hours there were *NO* faults seen
despite continously accessing the all the i2c devices. I feel the remaining issues
are related to the TPM not behaving properly at clock speeds of 285kHz or higher.
The other i2c hardware is fine up to maximum 400khz.  At these higher clock speeds
the TPM appears to fall behind and I see SDA held low after the TPM read and the
driver report bus arbitration lost errors.  Eventually the TPM completely stops
responding and SDA is held low. But accessing the other i2c hardware causes more
i2c clock pulses which lets the SDA go high again then the other i2c devices work
with out problems which further confirms our thinking that the TPM is source of the
remaining i2c problems.

  With the additional i2c fixes in the attached patch the Xilinx i2c driver
is working with out problems on our hardware. I recommend you consider adding these
changes which apply on top of the previous fixes that I sent.

  Thanks

        Andrew Worsley
