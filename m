From: Austin Christ <austinwc@codeaurora.org>
Subject: [PATCH v6 0/2] Add ACPI support and SMBus block read
Date: Tue, 11 Oct 2016 10:27:55 -0600
Message-ID: <1476203277-6893-1-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nkaje@codeaurora.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, timur@codeaurora.org, rruigrok@codeaurora.org, cov@codeaurora.org, Austin Christ <austinwc@qti.qualcomm.com>, sricharan@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Austin Christ <austinwc@qti.qualcomm.com>

Add ACPI support to I2C QUP driver and get properties from ACPI table.

Add support to the I2C QUP driver to correctly handle SMBus block reads by
checking I2C_M_RECV_LEN flag and reading the first byte received as the
message length.

Documentation for the two properites used from ACPI has been submitted through
dsd@acpica.org to https://github.com/ahs3/dsd. The documentation can be viewed
at https://lists.acpica.org/pipermail/dsd/2016-September/000095.html.

[V6]
 - correct block size for SMBus data read
[V5]
 - remove warning and use correct ACPI function
[V4]
 - correct error code
 - remove warning for fall back to default clock frequency
[V3]
 - clean up unused variables
 - use constant instead of variable for smbus length field
[V2]
 - rework the smbus block read and break into separate function
 - clean up redundant checks and variables

Naveen Kaje (2):
  i2c: qup: add ACPI support
  i2c: qup: support SMBus block read

 drivers/i2c/busses/i2c-qup.c | 122 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 19 deletions(-)

--
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
