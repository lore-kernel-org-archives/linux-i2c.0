From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [iio:testing 25/25] drivers/iio/magnetometer/ak09911.c:301
 ak09911_probe() error: we previously assumed 'id' could be null (see line
 288)
Date: Mon, 16 Jun 2014 10:24:26 +0300
Message-ID: <20140616072426.GK5015@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, kbuild@01.org
Cc: linux-i2c@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-i2c@vger.kernel.org

ak09911_probe() is called from i2c_device_probe() when we do:

	status = driver->probe(client, i2c_match_id(driver->id_table, client));

The functions which implement driver->probe() are not very consistent
in how the check for a NULL return from i2c_match_id().

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   3b60f3cdd600858142daaf8071501cbe72a9e2b9
commit: 3b60f3cdd600858142daaf8071501cbe72a9e2b9 [25/25] iio: AK09911 : 3 axis compass support

drivers/iio/magnetometer/ak09911.c:301 ak09911_probe() error: we previously assumed 'id' could be null (see line 288)

git remote add iio git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git remote update iio
git checkout 3b60f3cdd600858142daaf8071501cbe72a9e2b9
vim +/id +301 drivers/iio/magnetometer/ak09911.c

3b60f3cd Srinivas Pandruvada 2014-11-06  282  	mutex_init(&data->lock);
3b60f3cd Srinivas Pandruvada 2014-11-06  283  
3b60f3cd Srinivas Pandruvada 2014-11-06  284  	ret = ak09911_get_asa(client);
3b60f3cd Srinivas Pandruvada 2014-11-06  285  	if (ret)
3b60f3cd Srinivas Pandruvada 2014-11-06  286  		return ret;
3b60f3cd Srinivas Pandruvada 2014-11-06  287  
3b60f3cd Srinivas Pandruvada 2014-11-06 @288  	if (id)
3b60f3cd Srinivas Pandruvada 2014-11-06  289  		name = id->name;
3b60f3cd Srinivas Pandruvada 2014-11-06  290  	else if (ACPI_HANDLE(&client->dev))
3b60f3cd Srinivas Pandruvada 2014-11-06  291  		name = dev_name(&client->dev);
3b60f3cd Srinivas Pandruvada 2014-11-06  292  	else
3b60f3cd Srinivas Pandruvada 2014-11-06  293  		return -ENODEV;
3b60f3cd Srinivas Pandruvada 2014-11-06  294  
3b60f3cd Srinivas Pandruvada 2014-11-06  295  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
3b60f3cd Srinivas Pandruvada 2014-11-06  296  
3b60f3cd Srinivas Pandruvada 2014-11-06  297  	indio_dev->dev.parent = &client->dev;
3b60f3cd Srinivas Pandruvada 2014-11-06  298  	indio_dev->channels = ak09911_channels;
3b60f3cd Srinivas Pandruvada 2014-11-06  299  	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
3b60f3cd Srinivas Pandruvada 2014-11-06  300  	indio_dev->info = &ak09911_info;
3b60f3cd Srinivas Pandruvada 2014-11-06 @301  	indio_dev->name = id->name;

This is obviously a cut and paste bug and the ->name = name two lines
below is intended.

3b60f3cd Srinivas Pandruvada 2014-11-06  302  	indio_dev->modes = INDIO_DIRECT_MODE;
3b60f3cd Srinivas Pandruvada 2014-11-06  303  	indio_dev->name = name;
3b60f3cd Srinivas Pandruvada 2014-11-06  304  

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
