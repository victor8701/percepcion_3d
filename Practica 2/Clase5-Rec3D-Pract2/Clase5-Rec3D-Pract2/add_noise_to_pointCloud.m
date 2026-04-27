function point_cloud_out = add_noise_to_pointCloud(point_cloud_in, noise_factor)

noise = rand(size(point_cloud_in.Location)) * noise_factor;

cloud_aux = point_cloud_in.Location + noise;

point_cloud_out = pointCloud(cloud_aux);


end

