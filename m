From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: question about drivers/i2c/busses/i2c-davinci.c
Date: Sun, 6 Jan 2013 21:00:59 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1301062057260.2029@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The function davinci_i2c_remove in drivers/i2c/busses/i2c-davinci.c 
contains the following code:

         put_device(&pdev->dev);

         clk_disable_unprepare(dev->clk);
         clk_put(dev->clk);
         dev->clk = NULL;

         davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
 	free_irq(dev->irq, dev);

Is there any danger in putting free_irq(dev->irq, dev); after 
put_device(&pdev->dev);, because the interrupt handler i2c_davinci_isr can 
eg refer to dev->dev.

thanks,
julia
